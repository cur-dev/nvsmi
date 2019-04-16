#' NVML Initialization and Cleanup
#' 
#' Wrappers for NVML initialization and cleanup functions.
#' 
#' @details
#' Unlike all other wrappers, the naming scheme is
#' \itemize{
#'   \item initialization:
#'   \itemize{
#'     \item NVML name: \code{nvmlInit()}
#'     \item nvsmi name: \code{nvsmi_init()}
#'   }
#'   \item shutdown:
#'   \itemize{
#'     \item NVML name: \code{nvmlShutdown()}
#'     \item nvsmi name: \code{nvsmi_shutdown()}
#'   }
#' }
#' 
#' @references
#' \url{https://docs.nvidia.com/deploy/nvml-api/group__nvmlSystemQueries.html}
#' 
#' @name init
#' @rdname init
NULL



#' @useDynLib nvsmi R_nvsmi_init
#' @rdname init
#' @export
nvsmi_init = function()
{
  .Call(R_nvsmi_init)
  invisible()
}

#' @useDynLib nvsmi R_nvsmi_shutdown
#' @rdname init
#' @export
nvsmi_shutdown = function()
{
  .Call(R_nvsmi_shutdown)
  invisible()
}
