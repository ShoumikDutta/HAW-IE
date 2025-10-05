//Test exam: arts gallery.
//Visitors = threads;
//Use semaphore to handle the limited room space
//only 10 visitors simultan. are allowed to be in the room
//all others are waiting.

#include <pthread.h>
#include <stdio.h>
#include <semaphore.h>
#include <time.h>
#include <unistd.h>
#include <stdlib.h>

#define VISITORS 30
#define LIMIT 3

sem_t s;
int thread_counter[10];

// set current semaphore value 0 (the 3rd arg)
static int sem_counter = 0;

void *task2(void *param) {

	sem_wait(&s);
	printf("%d thread visiting... \n", *(int*)param);
	sleep(5);
    printf("%d thread exit! \n", *(int*)param);
	sem_post(&s);

	return NULL;
}

int main()
{
	//array of worker threads(visitors)
	pthread_t worker[VISITORS];  	
		
	//0-means shared between all threads
    sem_init(&s, 0, LIMIT);  
	int i = 0;
    printf("main thread started\n");

	for (i = 0; i < VISITORS; i++) {
		thread_counter[i] = i;
		pthread_create(&worker[i], 0, task2, &thread_counter[i]);
		//sleep(1);
	}

	//terminate each of the thread after it finishes its job
	for(i = 0; i < VISITORS; i++) {
		pthread_join(worker[i], NULL);
	}

	 printf("main thread ends here\n");
    return 0;
}


