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

1. Got an idea? Discuss the idea on [gitter](https://gitter.im/codEd-org/simulate#) or just open an issue with this [template](https://github.com/builtree/simulate/issues/new?assignees=&labels=enhancement%2C+new+simulation%2C+simulations&template=simulation-request.md&title=simulation%3A+%5BSIMULATION+TITLE%5D). If the maintainers find it interesting, the issue will be labeled accepted. If you want to work on it and don't know how to implement it yet, we'll help you get it done.
2. Even if you don't have an idea but are interested in working on one, checkout the [accepted simulation ideas](https://github.com/builtree/simulate/issues?q=is%3Aopen+is%3Aissue+label%3Aaccepted+label%3A%22new+simulation%22) and get assigned.
3. You can start working now! Make sure you ask for help when needed, it's okay to get stuck.

---

## Setting Up Docs

1. Install mkdocs and its requirements
```bash
python3 -m  pip install -r requirements-docs.txt
```
2. Check the installations by:
```bash
mkdocs --version
```

    !!! warning ""
        If this doesn't work, try restarting the terminal

3. Use the below command to host the documentation on local server
```bash
mkdocs serve --dev-addr 127.0.0.1:8000
```
{== MkDocs supports live reload so you don't have to run the server again and again. Just make your changes in the docs and you'll see the change immediately. ==}
4. All the documentation is present in the `docs` directory.

---

!!! quote ""
    *Don't hesitate in asking questions, it's a part of learning and everyone is here to help.*
