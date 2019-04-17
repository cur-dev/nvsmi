/* Automatically generated. Do not edit by hand. */

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include <stdlib.h>


extern SEXP R_nvsmi_init();
extern SEXP R_nvsmi_shutdown();

extern SEXP R_system_get_cuda_driver_version();
extern SEXP R_system_get_driver_version();
extern SEXP R_system_get_nvml_version();
extern SEXP R_system_get_process_name(SEXP pid);

extern SEXP R_device_get_board_part_number(SEXP device_ptr);
extern SEXP R_device_get_brand(SEXP device_ptr);
extern SEXP R_device_get_compute_mode(SEXP device_ptr);
extern SEXP R_device_get_count();
extern SEXP R_device_get_display_active(SEXP device_ptr);
extern SEXP R_device_get_fan_speed(SEXP device_ptr);
extern SEXP R_device_get_handle_by_index(SEXP index);
extern SEXP R_device_get_index(SEXP device_ptr);
extern SEXP R_device_get_memory_info(SEXP device_ptr);
extern SEXP R_device_get_name(SEXP device_ptr);
extern SEXP R_device_get_performance_state(SEXP device_ptr);
extern SEXP R_device_get_persistence_mode(SEXP device_ptr);
extern SEXP R_device_get_power_max(SEXP device_ptr);
extern SEXP R_device_get_power_usage(SEXP device_ptr);
extern SEXP R_device_get_serial(SEXP device_ptr);
extern SEXP R_device_get_temperature(SEXP device_ptr);
extern SEXP R_device_get_utilization(SEXP device_ptr);
extern SEXP R_device_get_uuid(SEXP device_ptr);

extern SEXP R_smi();

static const R_CallMethodDef CallEntries[] = {
  {"R_nvsmi_init", (DL_FUNC) &R_nvsmi_init, 0},
  {"R_nvsmi_shutdown", (DL_FUNC) &R_nvsmi_shutdown, 0},
  
  {"R_system_get_cuda_driver_version", (DL_FUNC) &R_system_get_cuda_driver_version, 0},
  {"R_system_get_driver_version", (DL_FUNC) &R_system_get_driver_version, 0},
  {"R_system_get_nvml_version", (DL_FUNC) &R_system_get_nvml_version, 0},
  {"R_system_get_process_name", (DL_FUNC) &R_system_get_process_name, 1},
  
  {"R_device_get_board_part_number", (DL_FUNC) &R_device_get_board_part_number, 1},
  {"R_device_get_brand", (DL_FUNC) &R_device_get_brand, 1},
  {"R_device_get_compute_mode", (DL_FUNC) &R_device_get_compute_mode, 1},
  {"R_device_get_count", (DL_FUNC) &R_device_get_count, 0},
  {"R_device_get_display_active", (DL_FUNC) &R_device_get_display_active, 1},
  {"R_device_get_fan_speed", (DL_FUNC) &R_device_get_fan_speed, 1},
  {"R_device_get_handle_by_index", (DL_FUNC) &R_device_get_handle_by_index, 1},
  {"R_device_get_index", (DL_FUNC) &R_device_get_fan_speed, 1},
  {"R_device_get_memory_info", (DL_FUNC) &R_device_get_memory_info, 1},
  {"R_device_get_name", (DL_FUNC) &R_device_get_name, 1},
  {"R_device_get_performance_state", (DL_FUNC) &R_device_get_performance_state, 1},
  {"R_device_get_persistence_mode", (DL_FUNC) &R_device_get_persistence_mode, 1},
  {"R_device_get_power_max", (DL_FUNC) &R_device_get_power_max, 1},
  {"R_device_get_power_usage", (DL_FUNC) &R_device_get_power_usage, 1},
  {"R_device_get_serial", (DL_FUNC) &R_device_get_performance_state, 1},
  {"R_device_get_temperature", (DL_FUNC) &R_device_get_temperature, 1},
  {"R_device_get_utilization", (DL_FUNC) &R_device_get_utilization, 1},
  {"R_device_get_uuid", (DL_FUNC) &R_device_get_temperature, 1},
  
  {"R_smi", (DL_FUNC) &R_smi, 0},
  
  {NULL, NULL, 0}
};

void R_init_coop(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
