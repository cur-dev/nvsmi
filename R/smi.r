#' smi
#' 
#' An \code{nvidia-smi} clone.
#' 
#' @return
#' A list with 3 elements of class \code{nvidia_smi}:
#' \itemize{
#'   \item \code{version}: 
#'   \item \code{date}: 
#'   \item The \code{gpus} dataframe: 
#'   \itemize{
#'     \item \code{name}: 
#'     \item \code{busid}: 
#'     \item \code{persistence_mode}: 
#'     \item \code{disp}: 
#'     \item \code{speed}: 
#'     \item \code{temp}: 
#'     \item \code{perf}: 
#'     \item \code{power}: 
#'     \item \code{power_max}: 
#'     \item \code{memory_used}: 
#'     \item \code{memory_total}: 
#'     \item \code{utilization}: 
#'     \item \code{compute_mode}: 
#'   }
#' }
#' 
#' @useDynLib nvsmi R_smi
#' @export
smi = function()
{
  date = format(Sys.time(), "%a %b %d %H:%M:%S %G")
  
  ret = .Call(R_smi)
  ret$date = date
  class(ret) = "nvidia_smi"
  
  ret
}
