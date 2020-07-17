# Account 

The ZDM allows the user to authenticate against the Zerynth backend.

## Login

The ```login``` command enables the user to login tot he ZDM with a Zerynth user.

```py
zdm login
```

The ZTC opens the default system browser to the login/registration page and waits for user input.

In the login/registration page, the user can login providing a valid email and the corresponding password.
It is also possible (and faster) to login using Google plus or Facebook OAuth services. If the user do not have a Zerynth account it is possible to register
providing a valid email, a nick name and a password. Social login is also available for registration via OAuth.

Once a correct login/registration is performed, the browser will display an authentication token. Such token can be copied and pasted to the ZTC prompt.

!!! warning
	Multiple logins with different methods (manual or social) are allowed provided that the email linked to the social OAuth service is the same as the one used in the manual login.

!!! warning
	For manual registrations, email address confirmation is needed. An email will be sent at the provided address with instructions.


## Logout

Delete current session with the following command

```py
zdm logout
```

It will be necessary to login again.


!!! note
    It is possible to change the password by issuing the `ztc` command:

    ```sh
    ztc reset email
    ```
    where `email` is the email address used in the manual registration flow. An email with instruction will be sent to such address in order to allow a password change.

	On password change, all active sessions of the user will be invalidated and a new token must be retrieved.
