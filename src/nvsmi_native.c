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

extern SEXP R_device_get_count();
extern SEXP R_device_get_handle_by_index(SEXP index);
extern SEXP R_device_get_name(SEXP device_ptr);
extern SEXP R_device_get_persistence_mode(SEXP device_ptr);
extern SEXP R_device_get_display_active(SEXP device_ptr);

extern SEXP R_smi();

static const R_CallMethodDef CallEntries[] = {
  {"R_nvsmi_init", (DL_FUNC) &R_nvsmi_init, 0},
  {"R_nvsmi_shutdown", (DL_FUNC) &R_nvsmi_shutdown, 0},
  
  {"R_system_get_cuda_driver_version", (DL_FUNC) &R_system_get_cuda_driver_version, 0},
  {"R_system_get_driver_version", (DL_FUNC) &R_system_get_driver_version, 0},
  {"R_system_get_nvml_version", (DL_FUNC) &R_system_get_nvml_version, 0},
  {"R_system_get_process_name", (DL_FUNC) &R_system_get_process_name, 1},
  
  {"R_device_get_count", (DL_FUNC) &R_device_get_count, 0},
  {"R_device_get_handle_by_index", (DL_FUNC) &R_device_get_handle_by_index, 1},
  {"R_device_get_name", (DL_FUNC) &R_device_get_name, 1},
  {"R_device_get_persistence_mode", (DL_FUNC) &R_device_get_persistence_mode, 1},
  {"R_device_get_display_active", (DL_FUNC) &R_device_get_display_active, 1},
  
  {"R_smi", (DL_FUNC) &R_smi, 0},
  
  {NULL, NULL, 0}
};

void R_init_coop(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
