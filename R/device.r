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



check_device_ptr = function(device)
{
  if (!inherits(device, "nvidia_device") || !isTRUE(typeof(device) == "externalptr"))
    stop("invalid device pointer")
}



#' @useDynLib nvsmi R_device_get_board_part_number
#' @rdname device
#' @export
device_get_board_part_number = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_board_part_number, device)
}

#' @useDynLib nvsmi R_device_get_compute_mode
#' @rdname device
#' @export
device_get_compute_mode = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_compute_mode, device)
}

#' @useDynLib nvsmi R_device_get_count
#' @rdname device
#' @export
device_get_count = function()
{
  .Call(R_device_get_count)
}

#' @useDynLib nvsmi R_device_get_display_active
#' @rdname device
#' @export
device_get_display_active = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_display_active, device)
}

#' @useDynLib nvsmi R_device_get_fan_speed
#' @rdname device
#' @export
device_get_fan_speed = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_fan_speed, device)
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

#' @useDynLib nvsmi R_device_get_index
#' @rdname device
#' @export
device_get_index = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_index, device)
}

#' @useDynLib nvsmi R_device_get_memory_info
#' @rdname device
#' @export
device_get_memory_info = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_memory_info, device)
}

#' @useDynLib nvsmi R_device_get_name
#' @rdname device
#' @export
device_get_name = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_name, device)
}

#' @useDynLib nvsmi R_device_get_performance_state
#' @rdname device
#' @export
device_get_performance_state = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_performance_state, device)
}

#' @useDynLib nvsmi R_device_get_persistence_mode
#' @rdname device
#' @export
device_get_persistence_mode = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_persistence_mode, device)
}

#' @useDynLib nvsmi R_device_get_power_max
#' @rdname device
#' @export
device_get_power_max = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_power_max, device)
}

#' @useDynLib nvsmi R_device_get_power_usage
#' @rdname device
#' @export
device_get_power_usage = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_power_usage, device)
}

#' @useDynLib nvsmi R_device_get_serial
#' @rdname device
#' @export
device_get_serial = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_serial, device)
}

#' @useDynLib nvsmi R_device_get_temperature
#' @rdname device
#' @export
device_get_temperature = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_temperature, device)
}

#' @useDynLib nvsmi R_device_get_utilization
#' @rdname device
#' @export
device_get_utilization = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_utilization, device)
}

#' @useDynLib nvsmi R_device_get_uuid
#' @rdname device
#' @export
device_get_uuid = function(device)
{
  check_device_ptr(device)
  .Call(R_device_get_uuid, device)
}
