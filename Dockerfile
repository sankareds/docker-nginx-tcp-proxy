FROM ubuntu:14.04

MAINTAINER YuLun Shih <shih@yulun.me>

RUN apt-get update && \
	apt-get -y install build-essential \
	libssl-dev \
	curl \
	libpcre3 \
	libpcre3-dev && \
	rm -rf /var/lib/apt/lists/* # 20150205

RUN curl -O http://nginx.org/download/nginx-1.6.2.tar.gz && \
	tar zxvf nginx-1.6.2.tar.gz && \
	curl -L -O https://github.com/yaoweibin/nginx_tcp_proxy_module/archive/v0.4.5.tar.gz && \
	tar zxvf v0.4.5.tar.gz && \
	rm -rf *.tar.gz && \
	cd nginx-1.6.2 && \
	patch -p1 < ../nginx_tcp_proxy_module-0.4.5/tcp.patch && \
	./configure --add-module=../nginx_tcp_proxy_module-0.4.5/ --with-http_ssl_module && \
	make && make install

CMD /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
