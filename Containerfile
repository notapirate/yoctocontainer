FROM docker.io/library/ubuntu:12.04

# change apt sources
RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
	gawk wget git-core diffstat unzip texinfo build-essential chrpath python quilt screen \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.utf8
ADD --chmod=755 entrypoint.sh /entrypoint.sh
VOLUME /yocto
ENTRYPOINT ["/entrypoint.sh"]
CMD /bin/bash
