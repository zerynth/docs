# Requests

This module implements functions to easily handle the intricacies of the HTTP protocol. The name and the API are inspired by the wonderful Python module [Requests](http://docs.python-requests.org/).
To use ```requests``` a net driver must have been properly configured and started.


**`get(url, params=None, headers=None, connection=None, stream_callback=None, stream_chunk=512)`**

Implements the GET method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```params``` is given as a dictionary, each pair (key, value) is appended to the requested url, properly encoded and sent.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection, ```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

If ```connection``` is given, the initial connection step is skipped and ```connection``` is used for communication. This feature allows the reuse of a connection to a HTTP server opened with a “Keep-Alive” header.

```get``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)

If the parameter ```stream_callback``` is given, the HTTP body data will be retrieved in chunk s of ```stream_chunk``` size and passed as arguments to ```stream_callback``` one by one. If ```stream_callback``` is used, the content of `Response()` instance is the last chunk.


**`post(url, data=None, json=None, headers=None, ctx=None)`**

Implements the POST method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

If ```data``` is provided (always as dictionary), each pair (key, value) will be form-encoded and send in the body of the request with {“content-type”:”application/x-www-form-urlencoded”} appended in the headers.
If ```json``` is provided (always as dictionary), json data will send in the body of the request with {“content-type”:”application/json”} appended in the headers.

```NOTE```: if both (```data``` and ```json```) dict are provided, json data are ignored and post request is performed with urlencoded data.

```post``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`put(url, data=None, json=None, headers=None, ctx=None)`**

Implements the PUT method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

If ```data``` is provided (always as dictionary), each pair (key, value) will be form-encoded and send in the body of the request with {“content-type”:”application/x-www-form-urlencoded”} appended in the headers.
If ```json``` is provided (always as dictionary), json data will send in the body of the request with {“content-type”:”application/json”} appended in the headers.

!!! note
	if both (```data``` and ```json```) dict are provided, json data are ignored and post request is performed with urlencoded data.

```put``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`patch(url, data=None, headers=None, ctx=None)`**

Implements the PATCH method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

If ```data``` is provided (always as dictionary), each pair (key, value) will be form-encoded and send in the body of the request with {“content-type”:”application/x-www-form-urlencoded”} appended in the headers.
If ```json``` is provided (always as dictionary), json data will send in the body of the request with {“content-type”:”application/json”} appended in the headers.

!!! note
	if both (```data``` and ```json```) dict are provided, json data are ignored and post request is performed with urlencoded data.

```patch``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`delete(url, headers=None, ctx=None)`**

Implements the DELETE method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

```delete``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`head(url, headers=None, ctx=None)`**

Implements the HEAD method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

```head``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`options(url, headers=None, ctx=None)`**

Implements the OPTIONS method of the HTTP protocol. A tcp connection is made to the host:port given in the url using the default net driver.

If ```headers``` is given as a dictionary, each pair (key, value) is appropriately sent as a HTTP request header. Mandatory headers are transparently handled: “Host:” is always derived by parsing ```url```;
other headers are set to defaults if not given: for example “Connection: close” is sent if no value for “Connection” is specified in ```headers```. To request a permanent connection,
```headers``` must contain the pair {“Connection”:”Keep-Alive”}.

```options``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, etc..)


**`upload(url, fd, ctx=None, mime_type="application/octet-stream", method="POST")`**

Upload a file identified by ```fd``` to ```url```. ```fd``` must provide methods read and size.

A tcp connection is made to the host:port given in the url using the default net driver.

The type of the file contents and the HTTP method (POST pr PUT) can be customized.

```upload``` returns a `Response()` instance.

Exceptions can be raised: `HTTPConnectionError` when the HTTP server can’t be contacted; `IOError` when the source of error lies at the socket level (i.e. closed sockets, invalid sockets, file, etc..)


**`Response()`**

This class represent the result of a HTTP request.

It contains the following members:


**`status()`**

Contains the HTTP response code


**`content()`**

It is the bytearray containing the byte version of the content section of a HTTP response


**`headers()`**

A dictionary with all the response headers


**`connection()`**

the connection used to communicate with the server, or None if it has been closed.


**`text()`**

Returns a string representing the content section of the HTTP response
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQ1ODA3ODI5OSwtODkxOTQxMzldfQ==
-->