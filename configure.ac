AC_INIT(DESCRIPTION)
AC_CONFIG_MACRO_DIR([tools/])

AX_GET_R_CPPFLAGS()
AC_PROG_CC_C99

AC_CHECK_LIB(nvidia-ml, nvmlInit, [], [
  AC_MSG_ERROR([could not find libnvidia-ml])
])


# Report
echo " "
echo "****************** Results of nvsmi package configure ******************"
echo " "
echo "* R Report:"
echo "    >> R_CPPFLAGS=${R_CPPFLAGS}"
echo "************************************************************************"
echo " "



dnl Start to substitute templates
AC_SUBST(NVCC)
AC_SUBST(CUDA_CFLAGS)
AC_SUBST(CUDA_LDFLAGS)
AC_SUBST(R_CPPFLAGS)
AC_OUTPUT(src/Makevars)
