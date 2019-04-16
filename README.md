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
## Mon Apr 15 20:00:24 2019 
## +-----------------------------------------------------------------------------+
## |      R-SMI 390.116                  Driver Version: 390.116                 |
## |-------------------------------+----------------------+----------------------+
## | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
## | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
## |===============================+======================+======================|
## |   0  GeForce GTX 107...  Off  | 00000000:08:00.0  On |
## | 39%   31C    P0    43W / 252W |    398MiB /  8116MiB |      3%      Default |
## +-------------------------------+----------------------+----------------------+
```

The default print method mimics the `nvidia-smi` utility. But there is also a "minimal" print method which I think is much better:

```r
options("nvsmi_printer"="minimal")
s
## +-----------------------------------------------------------------------------+
## | Date: Mon Apr 15 20:00:24 2019       Driver Version: 390.116                |
## |-------------------------------+----------------------+----------------------+
## | GPU Name               | Util  Fan  Temp   Perf        Power       Memory   |
## |==========================+==================================================|
## |   0 GeForce GTX 107... |   3%  39%   31C     P0     43W/252W   398/8116  MiB|
## +-------------------------------+----------------------+----------------------+
```

In this example we only have one GPU on the system, but data for all GPUs will be shown. Each GPU is a row in a dataframe:

```r
## str(s)
## List of 3
##  $ version: chr "390.116"
##  $ date   : chr "Mon Apr 15 20:00:24 2019"
##  $ gpus   :'data.frame':	1 obs. of  13 variables:
##   ..$ name            : chr "GeForce GTX 1070 Ti"
##   ..$ busid           : chr "00000000:08:00.0"
##   ..$ persistence_mode: logi FALSE
##   ..$ disp            : logi TRUE
##   ..$ speed           : int 39
##   ..$ temp            : int 31
##   ..$ perf            : int 0
##   ..$ power           : int 43208
##   ..$ power_max       : int 252000
##   ..$ memory_used     : num 4.18e+08
##   ..$ memory_total    : num 8.51e+09
##   ..$ utilization     : int 3
##   ..$ compute_mode    : chr "Default"
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
device_get_count()
device_get_handle_by_index(index)
device_get_name(device)
device_get_persistence_mode(device)
device_get_display_active(device)
device_get_fan_speed(device)
device_get_temperature(device)
```

High-level interface:

```r
smi()
```



## Using the Low Level API

* call `nvsmi_init()` before you do anything
* call `nvsmi_shutdown()` when you're done
* device pointers are invalid (but will not obviously be so) after calling `nvsmi_shutdown()`

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
