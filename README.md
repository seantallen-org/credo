# Credo

A containerized development environment runner

## Why Credo?

I've been using WSL 2 has my primary development environment for quite some time. It's an excellent tool for folks like me who do almost all their development in a Unix-like environment.

My take on WSL environments is a little different from many folks. I create mine by defining what I want in a Dockerfile and then building an image from that Dockerfile. Once I've built an image, I can export the filesystem as a tarball and import it into WSL. I started doing this because it made it easy for me to spin up new environments that already had a lot of my configuration done. Over time, I found myself spinning up new environments less and less. More and more often, I end up doing an `apt install` in my main environment to get a new tool. This was never my intent. I like to [keep thing hygienic](https://www.youtube.com/watch?v=eCDm2AZEe38). While setting up a new WSL environment is fairly easy, it's not as easy as setting up and running a container.

I started looking around for possible alternatives. My plan is to continue to have multiple WSL environments, but those environments will largely be purely about operating system updates. As you can tell, by reading this, I settled on using Docker containers for my development environments. I looked at a variety of options including [Vagrant](https://www.vagrantup.com/), [Multipass](https://canonical.com/multipass), and [devcontainers](https://containers.dev/).

Devcontainers was the closest to what I want. I gave it a go but ran into one large problem. Devcontainers is designed to store the "development environment information" within a project. This is great for teams to give a baseline environment. I, however, want environments that are tailored to me. I don't want to have to remember to copy a `.devcontainer` directory into every project I work on. I want to be able to spin up an environment that has all my tools and configuration ready to go. After learning what I liked and didn't like about devcontainers, I decided to roll my own. What devcontainers does it pretty straightforward and I can get everything I want directly from containers.

The key differences I aimed for were the aforementioned issues with devcontainers storing configuration within a project and how I like to interact with my terminal. The best devcontainers experience is with Visual Studio Code. When you fire up a devcontainer from VS Code, it opens a terminal in container. This is great in many ways except, I don't want to use my terminal in VS Code. I like to maximize all my windows and switch from one to another. I want a full screen of terminal and a full screen of editor. The IDE-like experience of VS Code's terminal isn't for me.

The bit of tooling that exists in this repo solves both. I can start up a development container via a terminal. I can attach to that running container from VS Code to edit code within it. And if I want to get additional shells in that environment, I can `docker exec` into it to get additional shells. This ends up being a lot like the experience I have with WSL 2, except, now with more hygiene; which is what I set out to achieve.

## Example Development Environments

To see containerized development environments designed to work with Credo, check out my [development environments](https://github.com/seantallen/dev-environments) repository.

## Supported Platforms

Credo only works within a Linux environment. You need a Linux installation, be it native or via WSL 2.

## Requirements

### At runtime

You need to have Docker installed and running. The `docker` command should be available on your $PATH.

### At build time

To build Credo, you'll need a working [Pony](https://www.ponylang.io/) installation. You also need:

- GNU make
- sed

## Build

```console
make credo
```

## Configuration

Credo is configured via a `config.json` file. The configuration file should be in `$HOME/.config/credo/config.json`. There's an [example configuration file](example-config.json) in this repository. To better understand it, you should probably check out my [development environments](https://github.com/seantallen/dev-environments) repository.

More documentation to come.

## Commands

Credo current supports two commands: `start` and `new`.

### start

Start spins up a development environment based on your configuration. Only a single instance of a development environment can be running at a time. If you try to start a new environment while one is running, you'll get an error.

```console
credo start corral-env
```

The name of the environment must correspond to the `name` key for an environment in your configuration file.

### new

Attaches a new shell to a running development environment. This is useful if you want to have multiple shells open in the same environment.

```console
credo new corral-env
```

The name of the environment must correspond to the `name` key for an environment in your configuration file.
