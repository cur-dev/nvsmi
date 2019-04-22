AC_INIT(DESCRIPTION)
AC_CONFIG_MACRO_DIR([tools/])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`

AC_LANG(C)
AC_PROG_CC_C99


AC_ARG_WITH(nvml-include,
  [  --with-nvml-include=DIR Location of nvml.h],
  [nvml_include=$withval],
  [nvml_include=""])

AC_ARG_WITH(nvml-lib,
  [  --with-nvml-lib=DIR     Location of libnvidia-ml.so],
  [nvml_lib=$withval],
  [nvml_lib=""])


for include_path in "${nvml_include}" "/usr/local/cuda/include"; do
  AC_MSG_NOTICE([checking for nvml.h in path=\"$include_path\"])
  AX_CHECK_NVML_INCLUDE()
  test "X$ac_cv_header_nvml_h" != "Xyes" || break
done

if test "X${ac_cv_header_nvml_h}" != "Xyes"; then
  AC_MSG_ERROR([could not find nvml.h])
fi


for lib_path in "${nvml_lib}" "/usr/local/cuda/lib64" "/usr/lib64/nvidia/"; do
  AC_MSG_NOTICE([checking for libnvidia-ml.so in path=\"$lib_path\"])
  AX_CHECK_NVML_LIB()
  test "X$ac_cv_lib_nvidia_ml_nvmlInit" != "Xyes" || break
done

if test "X$ac_cv_lib_nvidia_ml_nvmlInit" != "Xyes"; then
  AC_MSG_ERROR([could not find libnvidia-ml.so])
fi


# Report
echo " "
echo "****************** Results of nvsmi package configure ******************"
echo "* NVML:"
echo "    >> nvml_include=${NVML_INCLUDE}"
echo "    >> nvml_lib=${NVML_LIB}"
echo "************************************************************************"
echo " "



dnl Start to substitute templates
AC_SUBST(NVML_INCLUDE)
AC_SUBST(NVML_LIB)
AC_OUTPUT(src/Makevars)
