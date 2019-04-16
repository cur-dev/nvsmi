AC_DEFUN([AX_GET_R_CPPFLAGS], [

AC_SUBST([R_CPPFLAGS])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
CC=`"${R_HOME}/bin/R" CMD config CC`

AC_MSG_CHECKING(['R CMD config --cppflags'])
R_CPPFLAGS=`"${R_HOME}/bin/R" CMD config --cppflags`
if test "X${R_CPPFLAGS}" = "X"; then
  AC_MSG_RESULT([not found!])
  AC_MSG_FAILURE([R seemingly not built with '--enable-R-shlib=yes'; no way to proceed])
else
  AC_MSG_RESULT([ok])
fi

])
