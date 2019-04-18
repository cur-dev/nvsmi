#' gpu_processes
#' 
#' Returns the 
#' 
#' @param type
#' One of \code{"compute"} (CUDA processes), \code{"graphics"} (OpenGL, etc), or
#' \code{"both"} (CUDA + OpenGL).
#' 
#' @return
#' A dataframe with one row per process found, and 5 columns:
#' \itemize{
#'   \item \code{GPU}: 
#'   \item \code{PID}: 
#'   \item \code{Type}: 
#'   \item \code{Process}: 
#'   \item \code{Memory}: 
#' }
#' 
#' @export
gpu_processes = function(type="both")
{
  TYPE_BOTH = 1L
  TYPE_COMPUTE = 2L
  TYPE_GRAPHICS = 3L
  type = match.arg(tolower(type), c("both", "compute", "graphics"))
  type = ifelse(type == "both", TYPE_BOTH, ifelse(type == "compute", TYPE_COMPUTE, TYPE_GRAPHICS))
  
  nvsmi_init()
  ngpus = device_get_count()
  
  df = data.frame(GPU=integer(0), PID=integer(0), Type=character(0), Process=character(0), Memory=double(0), stringsAsFactors=FALSE)
  for (gpu in 0:(ngpus-1L))
  {
    g = device_get_handle_by_index(gpu)
    
    if (type == TYPE_BOTH || type == TYPE_COMPUTE)
    {
      compute = device_get_compute_running_processes(g)
      if (length(compute$pid) > 0)
      {
        names = sapply(compute$pid, system_get_process_name)
        df_compute = data.frame(GPU=gpu, PID=compute$pid, Type="C", Process=names, Memory=compute$memory_used, stringsAsFactors=FALSE)
        df = rbind(df, df_compute)
      }
    }
    
    if (type == TYPE_BOTH || type == TYPE_GRAPHICS)
    {
      graphics = device_get_graphics_running_processes(g)
      if (length(graphics$pid) > 0)
      {
        names = sapply(graphics$pid, system_get_process_name)
        df_graphics = data.frame(GPU=gpu, PID=graphics$pid, Type="G", Process=names, Memory=graphics$memory_used, stringsAsFactors=FALSE)
        df = rbind(df, df_graphics)
      }
    }
  }
  
  nvsmi_shutdown()
  
  df = df[order(df$GPU, df$PID), ]
  class(df) = c("nvidia_processes", "data.frame")
  df
}
