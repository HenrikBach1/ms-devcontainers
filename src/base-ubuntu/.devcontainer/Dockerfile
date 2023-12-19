# [Choice] Ubuntu version (use jammy on local arm64/Apple Silicon): jammy, focal
ARG VARIANT="jammy"
FROM buildpack-deps:${VARIANT}-curl

LABEL dev.containers.features="common"

# # [Optional] Uncomment this section to install additional OS packages.
# # HB: 1st/2nd: For Linux Kernel Development
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends \
#             build-essential cmake cppcheck valgrind clang lldb llvm gdb \
#             build-essential gdb git ctags make
