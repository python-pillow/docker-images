FROM quay.io/pypa/manylinux2014_x86_64:latest

RUN mkdir /src
ENV SRC=/src
ENV PATH=/opt/rh/devtoolset-9/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY build_depends.sh $SRC
COPY Pillow $SRC
COPY yum_install /usr/local/bin

RUN cd $SRC && bash build_depends.sh

FROM quay.io/pypa/manylinux2014_x86_64:latest
COPY --from=0 /usr/local/lib /usr/local/lib
COPY --from=0 /usr/local/include /usr/local/include
RUN yum install -y zlib-devel
COPY build.sh /build.sh

CMD ["/bin/sh /build.sh"]
