# Amazon Web Services IoT Jobs Library

The Zerynth AWS IoT Jobs Library can be used to handle [IoT Jobs](https://docs.aws.amazon.com/iot/latest/developerguide/iot-jobs.html) with ease.

## Jobs class


---
#### `#!py3 Jobs()`

!!!abstract "`#!py3 Jobs(thing)`"

This class allows the retrieval of the `thing` job list.

It requires the connection to thw MQTT broker to be already established: It subscribes to various
topic to receive jobs notifications.


---
#### `#!py3 changed()`

!!!abstract "`#!py3 changed()`"

Return True if there are new pending jobs. If called again, and in the meantime no new job notifications have been received, return False.


---
#### `#!py3 list()`

!!!abstract "`#!py3 list()`"

Retrieve the list of jobs for the current Thing. The result value is a tuple with two items. The first item is the list of IN_PROGRESS jobs, while the second item is the list of QUEUED jobs (as `Job()` instances).

This method is ```blocking```. Control is not released until the list of jobs is retrieved. Moreover, it is not safe to call the method from different threads.

## Job class


---
#### `#!py3 Job()`

!!!abstract "`#!py3 Job(thing, jobid)`"

This class abstracts an IoT Job related to a particular `thing` and having jobId `jobid`.
There is no need to manually create instances of this class, they are returned by methods of the `Jobs()` class.


---
#### `#!py3 describe()`

!!!abstract "`#!py3 describe()`"

Retrieves data about the job. In particular the fields `version`, `status` and `document` are associated to the job instance after a successful `describe`.

This method is ```blocking```. Control is not released until the job description is retrieved. Moreover, it is not safe to call the method from different threads.

Return True on success, False otherwise.


---
#### `#!py3 update()`

!!!abstract "`#!py3 update(status, status_details={})`"

Updates the status of the job. The `status` can be one of the following class constant:


* `Job.IN_PROGRESS`


* `Job.FAILED`


* `Job.SUCCEEDED`

The optional field `status_details` can contain custom values that are associated to the job status.

This method is ```blocking```. Control is not released until the status change is signaled. Moreover, it is not safe to call the method from different threads.

Return True on success, False otherwise.
