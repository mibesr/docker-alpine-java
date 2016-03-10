FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

ENV JAVA_HOME=/jre
ENV JAVA_VERSION_MAJOR=8  \
    JAVA_VERSION_MINOR=74 \
    JAVA_VERSION_BUILD=02 \
    JAVA_PACKAGE=server-jre \
    PATH=$PATH:$JAVA_HOME/bin \

RUN apk add --no-cache --virtual=build-dependencies curl ca-certificates && \
    cd /tmp && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz" \
        | tar -zxf - -C /tmp && \
    mv jdk1.$JAVA_VERSION_MAJOR.0_$JAVA_VERSION_MINOR/jre $JAVA_HOME && \
    rm -rf $JAVA_HOME/bin/jjs && \
           $JAVA_HOME/bin/keytool && \
           $JAVA_HOME/bin/orbd && \
           $JAVA_HOME/bin/pack200 && \
           $JAVA_HOME/bin/policytool && \
           $JAVA_HOME/bin/rmid && \
           $JAVA_HOME/bin/rmiregistry && \
           $JAVA_HOME/bin/servertool && \
           $JAVA_HOME/bin/tnameserv && \
           $JAVA_HOME/bin/unpack200 && \
           $JAVA_HOME/lib/ext/nashorn.jar && \
           $JAVA_HOME/lib/jfr.jar && \
           $JAVA_HOME/lib/jfr && \
           $JAVA_HOME/lib/oblique-fonts && \
    apk del build-dependencies && \
    rm -rf /tmp/*

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/urandom"]