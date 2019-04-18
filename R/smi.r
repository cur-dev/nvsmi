#' smi
#' 
#' An \code{nvidia-smi} clone.
#' 
#' @return
#' A list with 3 (4 if \code{processes=TRUE} elements of class \code{nvidia_smi}:
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
#' If \code{processes=TRUE} then it will also include the return of
#' \code{gpu_processes()}.
#' 
#' @seealso \code{\link{gpu_processes}}
#' 
#' @useDynLib nvsmi R_smi
#' @export
smi = function(processes=TRUE)
{
  date = format(Sys.time(), "%a %b %d %H:%M:%S %G")
  
  ret = .Call(R_smi)
  ret$date = date
  if (isTRUE(processes))
    ret$processes = gpu_processes()
  
  class(ret) = "nvidia_smi"
  ret
}
