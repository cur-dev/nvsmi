AC_DEFUN([AX_CHECK_NVML_INCLUDE], [

AC_SUBST([NVML_INCLUDE])

ax_save_CPPFLAGS="${CPPFLAGS}"

if test "X$include_path" = "X"; then
  NVML_INCLUDE=""
else
  NVML_INCLUDE="-I$include_path"
  CPPFLAGS="${CPPFLAGS} ${NVML_INCLUDE}"
fi

unset ac_cv_header_nvml_h
AC_CHECK_HEADER(nvml.h, [], [])

CPPFLAGS=${ax_save_CPPFLAGS}

])
