#' NVML System Queries
#' 
#' Wrappers for queries NVML runs against the local system.
#' 
#' @details
#' The function naming scheme for the wrappers is:
#' \itemize{
#'   \item NVML name: \code{nvmlFunctionName()}
#'   \item nvsmi name: \code{function_name()}
#' }
#' 
#' @param pid
#' Process id number.
#' 
#' @references
#' \url{https://docs.nvidia.com/deploy/nvml-api/group__nvmlSystemQueries.html}
#' 
#' @name system
#' @rdname system
NULL



#' @useDynLib nvsmi R_system_get_cuda_driver_version
#' @rdname system
#' @export
system_get_cuda_driver_version = function()
{
  .Call(R_system_get_cuda_driver_version)
}

#' @useDynLib nvsmi R_system_get_driver_version
#' @rdname system
#' @export
system_get_driver_version = function()
{
  .Call(R_system_get_driver_version)
}

#' @useDynLib nvsmi R_system_get_nvml_version
#' @rdname system
#' @export
system_get_nvml_version = function()
{
  .Call(R_system_get_nvml_version)
}

#' @useDynLib nvsmi R_system_get_process_name
#' @rdname system
#' @export
system_get_process_name = function(pid)
{
  if (is.null(pid) || is.na(pid) || !is.numeric(pid) || length(pid) != 1 || pid <= 0)
    stop("'pid' should be a positive integer")
  
  pid = as.integer(pid)
  .Call(R_system_get_process_name, pid)
}
