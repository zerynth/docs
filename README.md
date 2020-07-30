# Zerynth Documentation

## How to contribute (for non git savvy contributors)

The steps for contributing to the Zerynth Documentation are as follows:

1. decide a name for the change you want to make, i.e new_library_xxx
2. go to https://github.com/zerynth/docs/tree/test
3. create a branch named ```feature/new_library_xxx```: click on the branch dropdown (top left), type the branch name, click create. 
4. add all your changes to the newly created branch with whatever tool you prefer (i.e. https://stackedit.io)
5. after each change, the documentation will eventually be built at https://testdocs.zerynth.com/feature/new_library_xxx/latest
6. when you are happy with the result, go back to github on the branch ```feature/new_library_xxx``` and press Pull Request (top right, below the Code button)
7. in the next page choose ```base:test``` and ```compare:feature/new_library_xxx```. Then press "Create pull request"
8. in the next page, on the right top side, choose a reviewer ("zerynth" preferably)
9. wait for someone to accept your changes or to ask you for some modifications

You can work on multiple branches in parallel. Please, keep the work on each branch relative to a small amount of indipendent changes, otherwise reviewing youe work will be a nightmare (which means it won't be done).
