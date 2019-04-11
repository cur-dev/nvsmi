#include <nvml.h>
#include <Rinternals.h>


#define STRLEN 32
char str[STRLEN];


#define CHECK_NVML(call) {nvmlReturn_t check = call;check_nvml_ret(check);}

static inline void check_nvml_ret(nvmlReturn_t check)
{
  if (check != NVML_SUCCESS)
  {
    nvmlShutdown();
    
    if (check == NVML_ERROR_DRIVER_NOT_LOADED)
      error("nvidia driver is not running\n");
    else if (check == NVML_ERROR_NO_PERMISSION)
      error("NVML does not have permission to talk to the driver");
    else if (check == NVML_ERROR_UNKNOWN)
      error("something went wrong, but I don't know what");
  }
}



extern "C" SEXP R_smi()
{
  SEXP ret, ret_names;
  SEXP ret_version;
  SEXP ret_name, ret_speed, ret_temp, ret_power, ret_power_max;
  SEXP ret_memory_used, ret_memory_total, ret_utilization;
  
  // init
  CHECK_NVML( nvmlInit() );
  
  // driver
  CHECK_NVML( nvmlSystemGetDriverVersion(str, STRLEN) );
  PROTECT(ret_version = allocVector(STRSXP, 1));
  SET_STRING_ELT(ret_version, 0, mkChar(str));
  
  // card statistics
  unsigned int num_gpus;
  CHECK_NVML( nvmlDeviceGetCount(&num_gpus) );
  
  PROTECT(ret_name = allocVector(STRSXP, num_gpus));
  PROTECT(ret_speed = allocVector(INTSXP, num_gpus));
  PROTECT(ret_temp = allocVector(INTSXP, num_gpus));
  PROTECT(ret_power = allocVector(INTSXP, num_gpus));
  PROTECT(ret_power_max = allocVector(INTSXP, num_gpus));
  PROTECT(ret_memory_used = allocVector(REALSXP, num_gpus));
  PROTECT(ret_memory_total = allocVector(REALSXP, num_gpus));
  PROTECT(ret_utilization = allocVector(INTSXP, num_gpus));
  
  for (int i=0; i<num_gpus; i++)
  {
    nvmlDevice_t device;
    CHECK_NVML( nvmlDeviceGetHandleByIndex(i, &device) );
    
    CHECK_NVML( nvmlDeviceGetName(device, str, STRLEN) );
    SET_STRING_ELT(ret_name, i, mkChar(str));
    
    unsigned int speed;
    CHECK_NVML( nvmlDeviceGetFanSpeed(device, &speed) );
    INTEGER(ret_speed)[i] = speed;
    
    nvmlTemperatureSensors_t sensor = NVML_TEMPERATURE_GPU;
    unsigned int temp;
    CHECK_NVML( nvmlDeviceGetTemperature(device, sensor, &temp) );
    INTEGER(ret_temp)[i] = temp;
    
    unsigned int power;
    CHECK_NVML( nvmlDeviceGetPowerUsage(device, &power) );
    INTEGER(ret_power)[i] = power;
    
    unsigned int power_min, power_max;
    CHECK_NVML( nvmlDeviceGetPowerManagementLimitConstraints(device, &power_min, &power_max) );
    INTEGER(ret_power)[i] = power_max;
    
    nvmlMemory_t memory;
    CHECK_NVML( nvmlDeviceGetMemoryInfo(device, &memory) );
    REAL(ret_memory_used)[i] = (double) memory.used;
    REAL(ret_memory_total)[i] = (double) memory.total;
    
    nvmlUtilization_t utilization;
    CHECK_NVML( nvmlDeviceGetUtilizationRates(device, &utilization) );
    INTEGER(ret_utilization)[i] = utilization.gpu;
  }
  
  CHECK_NVML( nvmlShutdown() );
  
  int nret = 9;
  int n = 0;
  PROTECT(ret = allocVector(VECSXP, nret));
  PROTECT(ret_names = allocVector(STRSXP, nret));
  setAttrib(ret, R_NamesSymbol, ret_names);
  
  SET_VECTOR_ELT(ret, n, ret_version);
  SET_STRING_ELT(ret_names, n++, mkChar("version"));
  SET_VECTOR_ELT(ret, n, ret_name);
  SET_STRING_ELT(ret_names, n++, mkChar("name"));
  SET_VECTOR_ELT(ret, n, ret_speed);
  SET_STRING_ELT(ret_names, n++, mkChar("speed"));
  SET_VECTOR_ELT(ret, n, ret_temp);
  SET_STRING_ELT(ret_names, n++, mkChar("temp"));
  SET_VECTOR_ELT(ret, n, ret_power);
  SET_STRING_ELT(ret_names, n++, mkChar("power"));
  SET_VECTOR_ELT(ret, n, ret_power_max);
  SET_STRING_ELT(ret_names, n++, mkChar("power_max"));
  SET_VECTOR_ELT(ret, n, ret_memory_used);
  SET_STRING_ELT(ret_names, n++, mkChar("memory_used"));
  SET_VECTOR_ELT(ret, n, ret_memory_total);
  SET_STRING_ELT(ret_names, n++, mkChar("memory_total"));
  SET_VECTOR_ELT(ret, n, ret_utilization);
  SET_STRING_ELT(ret_names, n++, mkChar("utilization"));
  
  UNPROTECT(nret+2);
  return ret;
}
