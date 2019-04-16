dot_str = function(s, maxlen=18L)
{
  if (nchar(s) < maxlen)
    s
  else
    paste0(substr(s, 1, maxlen-3L), "...")
}



perf_str = function(s)
{
  if (s == 32)
    "Unknown"
  else
    sprintf("   P%-2d ", s)
}



onoff_str = function(s)
{
  ifelse(s, " On", "Off")
}



print_minimal = function(x)
{
  gpus = x$gpus
  ngpus = NROW(gpus)
  
  cat("+-----------------------------------------------------------------------------+\n")
  cat(sprintf("| Date: %-30s Driver Version: %-23s|\n", x$date, x$version))
  cat("|-------------------------------+----------------------+----------------------+\n")
  cat("| GPU Name               | Util  Fan  Temp   Perf        Power       Memory   |\n")
  cat("|==========================+==================================================|\n")
  
  for (gpu in 1:ngpus)
  {
    name = dot_str(gpus[gpu, "name"], 18)
    speed = gpus[gpu, "speed"]
    temp = gpus[gpu, "temp"]
    perf = perf_str(gpus[gpu, "perf"])
    power = gpus[gpu, "power"]/1000
    power_max = gpus[gpu, "power_max"]/1000
    memory_used = gpus[gpu, "memory_used"]/1024/1024
    memory_total = gpus[gpu, "memory_total"]/1024/1024
    utilization = gpus[gpu, "utilization"]
    
    memory = paste0(sprintf(" %5.0f", memory_used), "/", sprintf("%-5.0f", memory_total), " MiB")
    
    cat(sprintf("| %3d %-18s |", gpu-1L, name))
    cat(sprintf(" %3d%% %3d%%  %3dC  %s", utilization, speed, temp, perf))
    cat(sprintf("  %3.0fW/%3.0fW", power, power_max))
    cat(memory)
    cat("|\n")
  }
  
  cat("+-------------------------------+----------------------+----------------------+\n")
  
  invisible()
}



print_full = function(x)
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



#' print.nvidia_smi
#' Print \code{nvidia_smi} objects.
#' @param x
#' An \code{nvidia_smi} object.
#' @param ...
#' Ignored.
#' @export
print.nvidia_smi = function(x, ...)
{
  type = tolower(getOption("nvsmi_printer", default="full"))
  if (type == "minimal")
    print_minimal(x)
  else if (type == "full")
    print_full(x)
  else
    stop("'nvsmi_printer' should be one of 'full' or 'minimal'")
}
