#' System Management Interface
#' 
#' TODO
#' 
#' @useDynLib nvsmi R_smi
#' @export
smi = function()
{
  .Call(R_smi)
}
