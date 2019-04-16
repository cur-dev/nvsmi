#' smi
#' 
#' An \code{nvidia-smi} clone.
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
