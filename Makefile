
ifeq (${AMQPTOOLS_RABBITHOME},)
    AMQPTOOLS_RABBITHOME = /usr/local/src/rabbitmq/rabbitmq-c
endif

ifeq (${AMQPTOOLS_INSTALLROOT},)
    AMQPTOOLS_INSTALLROOT = /usr/local/bin
endif

ifeq (${AMQPTOOLS_DYNAMICLINK},)
    AMQPTOOLS_LDFLAGS = $(AMQPTOOLS_RABBITHOME)/librabbitmq/.libs/librabbitmq.so
else
    AMQPTOOLS_LDFLAGS = -lrabbitmq
endif

all: clean build

build: amqpspawn amqpsend

install: bin/amqpspawn bin/amqpsend
	install -D -m0755 bin/amqpspawn $(AMQPTOOLS_INSTALLROOT)/amqpspawn
	install -D -m0755 bin/amqpsend $(AMQPTOOLS_INSTALLROOT)/amqpsend

uninstall:
	rm -f $(AMQPTOOLS_INSTALLROOT)/amqpspawn
	rm -f $(AMQPTOOLS_INSTALLROOT)/amqpsend

amqpspawn: amqpspawn.c
	gcc -o bin/amqpspawn amqpspawn.c -I$(AMQPTOOLS_RABBITHOME)/librabbitmq $(AMQPTOOLS_LDFLAGS)

amqpsend: amqpsend.c
	gcc -o bin/amqpsend amqpsend.c -I$(AMQPTOOLS_RABBITHOME)/librabbitmq $(AMQPTOOLS_LDFLAGS)

clean:
	rm -f bin/amqpsend bin/amqpspawn
