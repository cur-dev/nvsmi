#' NVML Device Queries
#' 
#' Wrappers for queries NVML runs against a device.
#' 
#' @details
#' The function naming scheme for the wrappers is:
#' \itemize{
#'   \item NVML name: \code{nvmlFunctionName()}
#'   \item nvsmi name: \code{function_name()}
#' }
#' 
#' @references
#' \url{https://docs.nvidia.com/deploy/nvml-api/group__nvmlSystemQueries.html}
#' 
#' @name device
#' @rdname device
NULL



#' @useDynLib nvsmi R_device_get_count
#' @rdname device
#' @export
device_get_count = function()
{
  .Call(R_device_get_count)
}

#' @useDynLib nvsmi R_device_get_handle_by_index
#' @rdname device
#' @export
device_get_handle_by_index = function(index)
{
  if (is.null(index) || is.na(index) || !is.numeric(index) || length(index) != 1 || index < 0)
    stop("'index' should be a non-negative integer")
  
  index = as.integer(index)
  ngpus = device_get_count()
  if (!isTRUE(index < ngpus))
    stop(paste0("need 'index < device_get_count()', have index=", index, " and ngpus=", ngpus))
  
  ret = .Call(R_device_get_handle_by_index, index)
  class(ret) = "nvidia_device"
  attr(ret, "index") = index
  attr(ret, "ngpus") = ngpus
  ret
}

#' @useDynLib nvsmi R_device_get_name
#' @rdname device
#' @export
device_get_name = function(device)
{
  if (!inherits(device, "nvidia_device"))
    stop("invalid device pointer")
  
  .Call(R_device_get_name, device)
}
