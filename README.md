# nvsmi

* **Version:** 0.1-0
* **License:** [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt


An `nvidia-smi`-like interface for R.

This works via NVML, and does not require the `nvidia-smi` utility to be installed. Eventually the package will feature a full NVML interface.


## Installation

<!-- To install the R package, run:

```r
install.package("nvsmi")
``` -->

The development version is maintained on GitHub:

```r
remotes::install_github("wrathematics/nvsmi")
```

You will need to have an installation of CUDA to build the package. You can download CUDA from the [nvidia website](https://developer.nvidia.com/cuda-downloads).

Also, R must have been compiled with `--enable-R-shlib=yes`. Otherwise, the package probably won't build. 



## Example Usage

```r
s = nvsmi::smi()
s
## Thu Apr 18 12:32:24 2019 
## +-----------------------------------------------------------------------------+
## |      R-SMI 390.116                  Driver Version: 390.116                 |
## |-------------------------------+----------------------+----------------------+
## | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
## | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
## |===============================+======================+======================|
## |   0  GeForce GTX 107...  Off  | 00000000:08:00.0  On |
## | 39%   34C    P2    47W / 252W |    651MiB /  8116MiB |      0%      Default |
## +-------------------------------+----------------------+----------------------+
## 
## +-----------------------------------------------------------------------------+
## | Processes:                                                       GPU Memory |
## |  GPU       PID   Type   Process name                             Usage      |
## |=============================================================================|
## |    0      1781      G   /usr/lib/xorg/Xorg                           243MiB |
## |    0     26253      G   /opt/google/chrome/chrome --type=gpu-pr...    85MiB |
## +-----------------------------------------------------------------------------+
```

The default print method mimics the `nvidia-smi` utility. But there is also a "minimal" print method which I think is much better:

```r
options("nvsmi_printer"="minimal")
s
## +-----------------------------------------------------------------------------+
## | Date: Thu Apr 18 12:29:51 2019       Driver Version: 390.116                |
## |-------------------------------+----------------------+----------------------+
## | GPU Name               | Util  Fan  Temp   Perf        Power       Memory   |
## |==========================+==================================================|
## |   0 GeForce GTX 107... |   0%  39%   34C     P2     47W/252W   651/8116  MiB|
## +-------------------------------+----------------------+----------------------+
## 
## +-----------------------------------------------------------------------------+
## |  GPU       PID   Type   Process name                               Mem Used |
## |=============================================================================|
## |    0      1781      G   /usr/lib/xorg/Xorg                           243MiB |
## |    0     26253      G   /opt/google/chrome/chrome --type=gpu-pr...    85MiB |
## +-----------------------------------------------------------------------------+
```

In this example we only have one GPU on the system, but data for all GPUs will be shown. Each GPU is a row in a dataframe, and each process is listed in a separate dataframe:

```r
str(s)
## List of 4
##  $ version  : chr "390.116"
##  $ date     : chr "Thu Apr 18 12:29:51 2019"
##  $ gpus     :'data.frame':	1 obs. of  13 variables:
##   ..$ name            : chr "GeForce GTX 1070 Ti"
##   ..$ busid           : chr "00000000:08:00.0"
##   ..$ persistence_mode: logi FALSE
##   ..$ disp            : logi TRUE
##   ..$ speed           : int 39
##   ..$ temp            : int 34
##   ..$ perf            : int 2
##   ..$ power           : int 46942
##   ..$ power_max       : int 252000
##   ..$ memory_used     : num 6.83e+08
##   ..$ memory_total    : num 8.51e+09
##   ..$ utilization     : int 0
##   ..$ compute_mode    : chr "Default"
##  $ processes:Classes ‘nvidia_processes’ and 'data.frame':	2 obs. of  5 variables:
##   ..$ GPU    : int [1:2] 0 0
##   ..$ PID    : int [1:2] 1781 26253
##   ..$ Type   : chr [1:2] "G" "G"
##   ..$ Process: chr [1:2] "/usr/lib/xorg/Xorg" "/opt/google/chrome/chrome --type=gpu-process --field-trial-hand"
##   ..$ Memory : num [1:2] 2.55e+08 8.89e+07
##  - attr(*, "class")= chr "nvidia_smi"
```



## API

Initialization and Shutdown

```r
nvsmi_init()
nvsmi_shutdown()
```

System Queries

```r
system_get_cuda_driver_version()
system_get_driver_version()
system_get_nvml_version()
system_get_process_name(pid)
```

Device Queries

```r
device_get_board_part_number(device)
device_get_brand(device)
device_get_compute_mode(device)
device_get_compute_running_processes(device)
device_get_count()
device_get_cuda_compute_capability(device)
device_get_curr_pcie_link_generation(device)
device_get_curr_pcie_link_width(device)
device_get_display_active(device)
device_get_fan_speed(device)
device_get_graphics_running_processes(device)
device_get_handle_by_index(index)
device_get_index(device)
device_get_memory_info(device)
device_get_name(device)
device_get_performance_state(device)
device_get_persistence_mode(device)
device_get_power_max(device)
device_get_power_usage(device)
device_get_serial(device)
device_get_temperature(device)
device_get_utilization(device)
device_get_uuid(device)
```

High-level interface:

```r
gpu_processes(type="both")
smi(processes=TRUE)
```



## Using the Low Level API

* call `nvsmi_init()` before you do anything
* call `nvsmi_shutdown()` when you're done
* device pointers become invalid (but will not obviously be so) after calling `nvsmi_shutdown()`

Quick example:

```r
library(nvsmi)
nvsmi_init()

system_get_nvml_version()
## [1] "9.390.116"

device_get_count()
## [1] 1

d = device_get_handle_by_index(0)
d
## A device pointer to GPU 0 of 1 

device_get_name(d)
## [1] "GeForce GTX 1070 Ti"

nvsmi_shutdown()
```

The function `gpu_processes()` is build from the low-level API, so you can look at its source code for another example.
