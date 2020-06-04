# Operating System

This module implements a generic os interface.
To function correctly it needs a filesystem to be mounted, so that the module can use
the driver to access the underlying hardware.

```NOTE```: Every path needed as argument for an os function must follow chosen driver path convention. File/Directory access error due to low-level failure will raise an OSError.


---
#### `#!py3 exists()`

!!!abstract "`#!py3 exists(path)`"

Return True if path refers to an existing path, False otherwise.


---
#### `#!py3 isdir()`

!!!abstract "`#!py3 isdir(path)`"

Return True if path is an existing directory, False otherwise.


---
#### `#!py3 remove()`

!!!abstract "`#!py3 remove(path)`"

Remove (delete) the file path. If path is a directory, OSError is raised; see `rmdir()` below to remove a directory.


---
#### `#!py3 rmdir()`

!!!abstract "`#!py3 rmdir(path)`"

Remove (delete) the directory path. Only works when the directory is empty, otherwise, OSError is raised.


---
#### `#!py3 rename()`

!!!abstract "`#!py3 rename(src_path, dst_path)`"

Rename the file or directory src_path to dst_path. If dst_path is a directory, OSError will be raised.


---
#### `#!py3 mkdir()`

!!!abstract "`#!py3 mkdir(path)`"

Create a directory named path.


---
#### `#!py3 chdir()`

!!!abstract "`#!py3 chdir(path)`"

Change the current working directory to path.


---
#### `#!py3 getcwd()`

!!!abstract "`#!py3 getcwd()`"

Return a string representing the current working directory.

Since C filesystem drivers need a limit on returned string length:

```
os.cwd_max_length
```

attribute is set to 128 by default but can be adjusted, if needed, before calling `getcwd()`.


---
#### `#!py3 listdir()`

!!!abstract "`#!py3 listdir(path)`"

Return a list containing the names of the entries in the directory given by path. The list is in arbitrary order.
It does not include the special entries ‘.’ and ‘..’ even if they are present in the directory.


---
#### `#!py3 copyfile()`

!!!abstract "`#!py3 copyfile(src, dst)`"

Copy the contents of the file named src to a file named dst.

## The FileIO class


---
#### `#!py3 FileIO()`

!!!abstract "`#!py3 FileIO(path, mode = 'r')`"

Main class to handle files.


* path is a string (following chosen low-level filesystem driver format)


* mode is a string:

> 
>     * ‘r’       open for reading (default)


>     * ‘w’       open for writing, truncating the file first


>     * ‘a’       open for writing, appending to the end of the file if it exists


>     * ‘b’       binary mode


>     * ‘+’       open a disk file for updating (reading and writing)


---
#### `#!py3 read()`

!!!abstract "`#!py3 read(n_bytes = -1)`"

Read up to size bytes from the object and return them. As a convenience, if size is unspecified or -1, the whole file is read.
Return type can be string or bytes depending on chosen mode.

An empty string or an empty bytes object indicate end of file.


---
#### `#!py3 write()`

!!!abstract "`#!py3 write(to_w, sync = False)`"

Write to_w object (string or bytes) to the stream and return the number of characters written.

```sync``` parameter allows to write changes to disk immediately, without waiting `close()` call.


---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

Close file stream.


---
#### `#!py3 size()`

!!!abstract "`#!py3 size()`"

Return file size.


---
#### `#!py3 tell()`

!!!abstract "`#!py3 tell()`"

Return the current stream position.


---
#### `#!py3 seek()`

!!!abstract "`#!py3 seek(offset, whence=0)`"

Move the current position to ```offset``` bytes with respect to ```whence```.

```whence``` can be:


* 0: start of file


* 1: current position


* 2: end of file


---
#### `#!py3 truncate()`

!!!abstract "`#!py3 truncate()`"

Resize the stream to the given size in bytes (or the current position if size is not specified).
The current stream position isn’t changed.


---
#### `#!py3 readline()`

!!!abstract "`#!py3 readline()`"

Read until newline or EOF and return a single str.
If the stream is already at EOF, an empty string is returned.
