dot_str = function(s, maxlen=11L)
{
  if (nchar(s) < 18)
    s
  else
    paste0(substr(s, 1, 15), "...")
}



perf_str = function(s)
{
  if (s == 32)
    " Unknown"
  else
    sprintf("   P%-2d ", s)
}



onoff_str = function(s)
{
  ifelse(s, " On", "Off")
}



#' print.nvidia_smi
#' Print \code{nvidia_smi} objects.
#' @param x
#' An \code{nvidia_smi} object.
#' @param ...
#' Ignored.
#' @export
print.nvidia_smi = function(x, ...)
{
  d = format(Sys.time(), "%a %b %d %H:%M:%S %G")
  gpus = x$gpus
  ngpus = NROW(gpus)
  
  
  cat(d, "\n")
  cat("+-----------------------------------------------------------------------------+\n")
  cat(sprintf("|      R-SMI %-24s Driver Version: %-24s|\n", x$version, x$version))
  cat("|-------------------------------+----------------------+----------------------+\n")
  cat("| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |\n")
  cat("| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |\n")
  cat("|===============================+======================+======================|\n")
  
  for (gpu in 1:ngpus)
  {
    name = dot_str(gpus[gpu, "name"])
    persistence_mode = onoff_str(gpus[gpu, "persistence_mode"])
    cat(sprintf("| %3d  %-18s  %s  |", gpu-1L, name, persistence_mode))
    
    busid = gpus[gpu, "busid"]
    disp = onoff_str(gpus[gpu, "disp"])
    cat(sprintf(" %s %s ", busid, disp))
    cat("|\n")
    
    
    speed = gpus[gpu, "speed"]
    temp = gpus[gpu, "temp"]
    perf = perf_str(gpus[gpu, "perf"])
    power = gpus[gpu, "power"]/1000
    power_max = gpus[gpu, "power_max"]/1000
    cat(sprintf("|%3d%%  %3dC %s %3.0fW / %3.0fW ", speed, temp, perf, power, power_max))
    
    memory_used = gpus[gpu, "memory_used"]/1024/1024
    memory_total = gpus[gpu, "memory_total"]/1024/1024
    cat(sprintf("|  %5.0fMiB / %5.0fMiB ", memory_used, memory_total))
    
    utilization = gpus[gpu, "utilization"]
    compute_mode = gpus[gpu, "compute_mode"]
    cat(sprintf("|     %2d%% %12s ", utilization, compute_mode))
    cat("|\n")
  }
  
  cat("+-------------------------------+----------------------+----------------------+\n")
  
  invisible()
}
