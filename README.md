# yoctocontainer

This project provides OCI containers that can be used as ubuntu-based yocto build backends. They contain everything that yocto needs to build. Simply mount your sources/build folder as volume into the container. The entrypoint script will run the `oe-init-build-env` script, so you can run bitbake commands as CMD.

## Build

### Use prebuild containers

The easiest way is to use the prebuild containers that are in the github container registry. Login to `ghcr.io` and see if your preferred ubuntu version is available.

### Build container

If you want to make changes to the container, you can build it yourself. Checkout your preferred ubuntu branch (e.g. `ubuntu-20.04`) and build your own container, preferably with podman.

## Run on linux host

I suggest to run the container with podman. Bitbake complains if it is run with UID 0, which is the default within containers. Fortunately `podman run` has the option `--userns=keep-id`, which maps your current UID into the container. This way all build fragments will also be created with your UID and are easily accessible outside the container.

The volume is the root dir of both your sources and your build fragments and is expected on `/yocto` within the container. The default volume looks like this:

- /sources/poky: poky sources checkout (env var: `POKY_DIR`)
- /build: folder that contains build configs and fragments (env var: `BDIR`)

So for example, if you have poky in `~/yoctoproject/sources/poky` and your build folder in `~/yoctoproject/build`, you mount `~/yoctoproject` as `/yocto` into the container.
If your prefer a different folder structure, please set the environment variables `POKY_DIR` and `BDIR` accordingly.

I suggest the following command to run bitbake in a yoctocontainer:

``podman run --userns=keep-id --env-host -v <path/to/yocto/dir>:/yocto:U -v tmpfs:/tmp -it ghcr.io/notapirate/yoctocontainer-ubuntu-20.04:1.0 bitbake <imagerecipe>``

### Alias

For convenience you can use the following bitbake alias, just add it to your `~/.bashrc`:

`alias bitbake='podman run --userns=keep-id --env-host -v <path/to/yocto/dir>:/yocto:U -v tmpfs:/tmp -it ghcr.io/notapirate/yoctocontainer-ubuntu-20.04:1.0 bitbake $@'`

### .gitconfig

You may want to use `devshell` and create git commits within the container, which requires `~/.gitconfig`. The yocto root dir `/yocto` is also set as `HOME` dir, so you can mount your `.gitconfig` there, just add `-v ~/.gitconfig:/yocto/.gitconfig:U` to the command.

## Run on Windows / macOS host

I haven't figured out how to successfully run the container on windows or macos hosts; if you find out, feel free to tell me :)