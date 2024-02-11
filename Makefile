CC = gcc
CFLAGS = -static -std=gnu11 -fopenmp -march=native -O3
SRCS = $(wildcard *.c)

OBJS = $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SRCS)))

%.o: %.c
	$(CC) $(CFLAGS) -o $@ $< -lm
%.o: %.cpp
	$(CXX) $(CFLAGS) -o  $@ $< -lm

.PHONY: all
all: $(OBJS)

run:
	python3 main.py

.PHONY: clean
clean:
	-rm -f *.o
