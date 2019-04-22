AC_DEFUN([AX_CHECK_NVML_LIB], [

AC_SUBST([NVML_LIB])

ax_save_LDFLAGS="${LDFLAGS}"

if test "X$lib_path" = "X"; then
  NVML_LIB=""
else
  NVML_LIB="-L$lib_path"
  LDFLAGS="${LDFLAGS} ${NVML_LIB}"
fi

unset ac_cv_lib_nvidia_ml_nvmlInit
AC_CHECK_LIB(nvidia-ml, nvmlInit, [], [])

LDFLAGS=${ax_save_LDFLAGS}

])
