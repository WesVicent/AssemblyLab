# ASM x86 Dev Environment

This repository provides a portable x86 Assembly (NASM) development environment using Docker + CMake, along with helper scripts to streamline project creation and builds.


### You have three main scripts:

| Script | Purpose |
|------|--------|
| `./runcontainer.sh` | Starts the Docker-based Linux dev environment |
| `./newproj.sh <name>` | Creates a new ASM project from template |
| `./<project>/build.sh` | Builds and runs a specific project |


### Requirements

* Docker installed
* Bash shell (Linux, or WSL2)

---

# 1. Start the Dev Environment

```bash
./runcontainer.sh
```

This will:

* Build the Docker image (only once)
* Start an interactive Linux shell
* Mount your current folder into the container

Your files stay on your host machine.

---

# 2. Create a New Project

```bash
./newproj.sh myProject
```

This will:

* Copy the `0-template/` folder
* Rename it to `myProject/`
* Update `.env` with:

```env
PROJECT_NAME=myProject
```

---

# 3. Build and Run a Project

```bash
./myProject/build.sh

OR

cd myProject
./build.sh
```

This will:

* Load `PROJECT_NAME` from `.env`
* Run CMake build
* Execute the compiled binary

---

# Overview

## Docker

* Provides a consistent Linux environment
* Includes NASM, GCC, CMake, GDB
* No need to install anything locally

### Rebuilding Docker Image

If you change the Dockerfile:

```bash
docker build -t asm-cmake-dev .
```

## CMake

* Builds the assembly project
* Outputs binary to:

```bash
out/bin/<PROJECT_NAME>
```

## .env

Controls project configuration:

```env
PROJECT_NAME=myProject
```

## Structure

```bash
# Start environment
./runcontainer.sh

# Create project
./newproj.sh testApp

# Enter project
cd testApp

# Build & run
./build.sh
```

---

## Windows Users

* Prefer using **WSL2**
* If using Git Bash, ensure paths are handled correctly

---



### License
```

I.D.C. - Free to use and modify.

```
