# Contributing
!!! note ""
    Before contributing, we highly recommend introducing yourself and your ideas on [gitter](https://gitter.im/codEd-org/simulate#).

## Setting Up Simulate

1. Make sure you have Flutter installed (https://flutter.dev/docs/get-started/install)
2. Fork the repository
3. Clone the forked repository:
```
git clone https://github.com/[YOUR USERNAME]/simulate.git
```
4. Connect a device or run an emulator (Make sure your connected device has USB Debugging enabled) 
5. Navigate to the project directory and Run:
```bash
cd simulate
flutter run
```

---

## Building your stuff

#### Fixing a bug:

1. Open an issue or report on [gitter](https://gitter.im/codEd-org/simulate#)
2. Make a new branch
```console
git checkout -b [BRANCH NAME]
```
3. Fix the bug, push and open a pull request

#### Adding a new Simulation:

1. Discuss the idea first on [gitter](https://gitter.im/codEd-org/simulate#) or just open an issue with the template.
2. Discuss with the maintainers and get a simulation ID assigned.
3. Build your simulation and open a PR!

---

## Setting Up Docs

1. Install mkdocs
```bash
python3 -m pip install mkdocs
```
2. Check the installations by:
```bash
mkdocs --version
```

    !!! warning ""
        If this doesn't work, try restarting the terminal

3. Use the below command to host the documentation on local server
```bash
mkdocs serve
```
{== MkDocs supports live reload so you don't have to run the server again and again. Just make your changes in the docs and you'll see the change immediately. ==}
4. All the documentation is present in the `docs` directory.

---

!!! quote ""
    *Don't hesitate in asking questions, it's a part of learning and everyone is here to help.*
