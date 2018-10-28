FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y tcl wget make build-essential
RUN wget http://download.redis.io/redis-stable.tar.gz
RUN tar xvzf redis-stable.tar.gz 

RUN cd redis-stable/deps/ && make hiredis lua jemalloc linenoise 
RUN cd redis-stable && make && make test && make install

RUN mkdir /etc/redis
RUN mkdir /var/redis
RUN mkdir /var/redis/6379

ADD redis_init /etc/init.d/redis_6379
ADD redis.conf /etc/redis/6379.conf

RUN chmod a+x /etc/init.d/redis_6379
RUN update-rc.d redis_6379 defaults

CMD /etc/init.d/redis_6379 start && tail -f /dev/null

