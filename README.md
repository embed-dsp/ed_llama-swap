
# Installation of llama-swap

This repository contains bash scripts for installing and running the 
[llama-swap](https://github.com/mostlygeek/llama-swap)
proxy server and for configuring the **local LLM**'s.


## Overview

The `bin` directory contains the following bash scripts:

```text
bin/
├── download_install.sh # Download and install llama-swap proxy server, run_llama-swap.sh script and config.yaml in the local file system.
└── run_llama-swap.sh   # Run the llama-swap proxy server.
```

The `etc` directory contains the following configuration file:

```text
etc/
└── config.yaml         # Configuration of llama-swap server and local LLM's.
```

**NOTE**: The `llama-swap` proxy server requires that the `llama.cpp` server is installed on the system.
Instructions for build and installation of `llama.cpp` server can be found here [ed_llama.cpp](https://github.com/embed-dsp/ed_llama.cpp)


## Local Installation

Enter the `bin` directory.

Type the following command, where `<release-number>` is the desired release number.

```sh
# Command
./download_install.sh <release-number>
```

The `llama-swap` proxy server, `run_llama-swap.sh` script and `config.yaml` are
installed in the local file system in `/opt/llama-swap`:

```text
/opt/llama-swap
├── bin
│   ├── llama-swap          # llama-swap proxy server
│   └── run_llama-swap.sh   # Run the llama-swap proxy server with the configuration.
└── etc
    └── config.yaml         # Configuration of llama-swap server and local LLM's.
```

Symbolic links are created from `/opt/bin` to `/opt/llama-swap/bin`.

```text
/opt/bin/
    llama-swap -> /opt/llama-swap/bin/llama-swap
    run_llama-swap -> /opt/llama-swap/bin/run_llama-swap.sh
```


## Links

* https://github.com/mostlygeek/llama-swap
* https://github.com/mostlygeek/llama-swap/releases
* https://github.com/mostlygeek/llama-swap/blob/main/docs/configuration.md


## LLM Models

### Qwen

Information

* [Qwen3.6-27B: Flagship-Level Coding in a 27B Dense Model](https://qwen.ai/blog?id=qwen3.6-27b)
* [Qwen3.6-35B-A3B: Agentic Coding Power, Now Open to All](https://qwen.ai/blog?id=qwen3.6-35b-a3b)
* [Qwen3-VL: Sharper Vision, Deeper Thought, Broader Action](https://qwen.ai/blog?id=qwen3-vl)

Models

* [qwen3.6-27b](https://huggingface.co/unsloth/Qwen3.6-27B-MTP-GGUF)
* [qwen3.6-35b-a3b](https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF)
* [qwen3-vl-32b-instruct](https://huggingface.co/unsloth/Qwen3-VL-32B-Instruct-GGUF)
* [qwen3-vl-30b-a3b-instruct](https://huggingface.co/unsloth/Qwen3-VL-30B-A3B-Instruct-GGUF)

### Google DeepMind

Information

* [Gemma](https://deepmind.google/models/gemma/)
* [Gemma 4](https://deepmind.google/models/gemma/gemma-4)

Models

* [gemma-4-31b-it](https://huggingface.co/unsloth/gemma-4-31B-it-GGUF)
* [gemma-4-26b-a4b-it](https://huggingface.co/unsloth/gemma-4-26B-A4B-it-GGUF)
* [gemma-4-12b-it](https://huggingface.co/unsloth/gemma-4-12b-it-GGUF)
