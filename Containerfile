FROM docker.io/library/ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
	gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat python quilt screen \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.utf8
ADD --chmod=755 entrypoint.sh /entrypoint.sh
VOLUME /yocto
ENTRYPOINT ["/entrypoint.sh"]
CMD /bin/bash
