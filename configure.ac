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
AC_PROG_CC_C99


AC_ARG_WITH(nvml-include,
  [  --with-nvml-include=PREFIX      Location of nvml.h],
  [nvml_include=$withval],
  [nvml_include=""])

AC_ARG_WITH(nvml-lib,
  [  --with-nvml-lib=PREFIX      Location of libnvidia-ml.so],
  [nvml_lib=$withval],
  [nvml_lib=""])


save_CPPFLAGS="${CPPFLAGS}"
save_LDFLAGS="${LDFLAGS}"

if test "X${nvml_include}" != "X"; then
  NVML_INCLUDE="-I${nvml_include}"
  CPPFLAGS="${CPPFLAGS} ${NVML_INCLUDE}"
fi

AC_CHECK_HEADER(nvml.h, [], [
  AC_MSG_ERROR([could not find nvml.h])
])

CPPFLAGS=${save_CPPFLAGS}

if test "X${nvml_lib}" != "X"; then
  NVML_LIB="-L${nvml_lib}"
  LDFLAGS="${LDFLAGS} ${NVML_LIB}"
fi

AC_CHECK_LIB(nvidia-ml, nvmlInit, [], [
  AC_MSG_ERROR([could not find libnvidia-ml])
])

LDFLAGS=${save_LDFLAGS}

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
