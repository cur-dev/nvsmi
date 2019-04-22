AC_DEFUN([AX_CHECK_NVML_LIB], [

AC_SUBST([NVML_LIB])

ax_save_LDFLAGS="${LDFLAGS}"
LIB_PATH=$1
USE_RPATH=$2

if test "X$LIB_PATH" = "X"; then
  NVML_LIB=""
else
  NVML_LIB="-L$LIB_PATH"
  if test "X$USE_RPATH" = "Xyes"; then
    NVML_LIB="$NVML_LIB -Wl,-rpath=$LIB_PATH"
  fi
  LDFLAGS="${LDFLAGS} ${NVML_LIB}"
fi

unset ac_cv_lib_nvidia_ml_nvmlInit
AC_CHECK_LIB(nvidia-ml, nvmlInit, [], [])

LDFLAGS=${ax_save_LDFLAGS}

])
