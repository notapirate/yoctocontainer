FROM docker.io/library/ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
	gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 pylint python3-subunit locales file lz4 zstd quilt screen nano \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ADD --chmod=755 entrypoint.sh /entrypoint.sh
VOLUME /yocto
ENTRYPOINT ["/entrypoint.sh"]
CMD /bin/bash
