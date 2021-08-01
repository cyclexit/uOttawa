EXES += catalan_producer.out catalan_consumer.out shm_delete.out
OBJS += shm_utils.o

%.o: %.c %.h
	gcc -c $< -o $@

%.o: %.c
	gcc -c $< -o $@

%.out: %.o $(OBJS)
	gcc $< $(OBJS) -o $@

all: $(EXES)

clean:
	rm $(EXES)

.PHONY: all clean