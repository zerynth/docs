# fatFS

This module implements Zerynth binding to [FatFS C library](http://elm-chan.org/fsw/ff/00index_e.html) to handle FAT disks.

## Driver


---
#### `#!py3 mount()`

!!!abstract "`#!py3 mount(path, args)`"

Register/unregister a file system object to the fatFs module.
There is no activity of the physical drive in this function: physical mount process will be attempted during first file access.

Required arguments are:


* path string, following FatFS path convention:

```
path = "0:/" # to mount your drive as volume 0

generic_file_path = "0:/my/file/path"
```


* args dictionary containing disk initialization parameters:

```
# correct format for SD Card read through SPI protocol
args = {"drv": SPI0, "cs": D25, "clock": 1000000}

# correct format for SD Card read through SD mode
# (be careful in choosing frequency (kHz) and bits supported by your board)
args = {"drv": SD1, "freq_khz": 20000, "bits": 1}
```

## File/Directory Access/Management

File/Directory access/management is handled by os module, which needs a filesystem to be mounted
and a list of low-level functions implemented in the filesystem module.


* File Access

> 
>     * __f_open


>     * __f_close


>     * __f_read


>     * __f_write


>     * __f_seek


>     * __f_size


>     * __f_tell


>     * __f_truncate


>     * __f_eof


* Directory Access

> 
>     * __f_opendir


>     * __f_closedir


>     * __f_readdir


* File/Directory Management

> 
>     * __f_copy


>     * __f_unlink


>     * __f_rename


>     * __f_mkdir


>     * __f_chdir


>     * __f_getcwd


>     * __f_exists


>     * __f_isdir


* Misc

> 
>     * get_available_fd_n


>     * free_fd_n


>     * to_b_mode
