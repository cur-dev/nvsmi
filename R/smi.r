#' smi
#' 
#' An \code{nvidia-smi} clone.
#' 
#' @useDynLib nvsmi R_smi
#' @export
smi = function()
{
  ret = .Call(R_smi)
  class(ret) = "nvidia_smi"
  
  ret
}
