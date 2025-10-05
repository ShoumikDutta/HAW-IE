//The program logic is correct!
//queue output is wrong :(
//mq_receive doesn't wait for sent message but output nothing directly!

//use msg queue approach to deal to deal with communication
//between children and ecological system

//each parent-child pair should have it's own queue for communication
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>
#include <mqueue.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>

#define ZMAX 80
#define PRIO 0
#define MODE (S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH |S_IWOTH)

//Jackalope stuff
#define CAPACITY 10
#define LIFETIME 10
#define REPRODUCTION_RATE 5

int ready = 0;
void sigint(int signum);

int main(void)
{
	char cQueue[100];
	mqd_t tmq; //main queue
	char msgbuf[ZMAX];
	unsigned int prio, i=0;
	pid_t npid_child;
	size_t anz = 0;
	struct mq_attr mqattr;
	char child_counter = 0;
	
	mqattr.mq_maxmsg = ZMAX;
	mqattr.mq_msgsize = ZMAX;
	mqattr.mq_flags = 0;
	
	//npid_child = fork();
	
	//set function calls -- for both child and parent the same)
	if(signal(SIGINT, sigint)) {
		perror("signal()");
		exit(1);
	}

	for(i = 0; i<=10; i++) {
		if(i % REPRODUCTION_RATE == 0) { //born new child
			npid_child = fork();		
		}
		
		if(npid_child) { //parent
			if((i+1) % LIFETIME == 0){
				printf("Jack-%d, t = %d: I am dead.\n", getpid(), i);
				if (mq_unlink(cQueue) != 0) {
				printf ("Can't remove Message Queue %s (%s)\n", cQueue, strerror(errno));
			return EXIT_FAILURE;
				}
				kill(getpid(), SIGKILL); //kill process			
			}
			if(i % REPRODUCTION_RATE == 0) { //born new child
				sprintf(cQueue, "/Queue%d", npid_child);
				tmq = mq_open(cQueue, O_CREAT|O_RDWR, MODE, &mqattr);
				//convert the #child into a char and send via msg queue
				sprintf(msgbuf, "%d", child_counter++);
				mq_send(tmq, "hi", sizeof(msgbuf), PRIO);
				kill(npid_child, SIGINT);
				printf("%s => PARENT %d: sent msg: %s to child %d\n", cQueue, getpid(), msgbuf, npid_child);
				//printf("Jack-%d, t = %d: %d birth, child'name %d\n", getpid(), i, child_counter, npid_child);	
			}

			sleep(1);
		
		} else { //child
			//open the msg queue to read the msg
			if(ready) { //signal arrived 
				tmq = mq_open(cQueue, O_RDONLY);
				ready = 0;
			}
			if((anz=mq_receive(tmq,msgbuf,sizeof(msgbuf),&prio))>0) {
				printf("%s => CHILD %d: rec msg: %s from parent %d (anz = %ld)\n", cQueue, getpid(), msgbuf, getppid(), anz);
			//	printf("Jack-%d, t = %d: I am new born. My father: %d\n", getpid(), i, getppid());		
			}
			sleep(1);
		}
			
	}	



/*
	for(i = 0; i<=20; ++i) {
		if()
		
		if(npid_child) { //parent
			if((i+1) % LIFETIME == 0){
				printf("Jack-%d, t = %d: I am dead.\n", getpid(), i);
				kill(getpid(), SIGKILL); //kill process			
			}
			//open the msg queue to read the msg
			usleep(1000);
			tmq = mq_open(cQueue, O_RDONLY);
			if((anz=mq_receive(tmq,msgbuf,sizeof(msgbuf),&prio))>0){
				printf("Jack-%d, t = %d: %s birth, child'name %d\n", getpid(), i, msgbuf, npid_child);	
			}
			sleep(1);
			
		} else {	//child
			if((i+1) % REPRODUCTION_RATE == 0) { //born new child
				npid_child = fork();
				//i = 0;
				child_counter++;
				printf("Jack-%d, t = %d: I am new born. My father: %d\n", getpid(), i, getppid());		
				sprintf(cQueue, "/Queue%d", npid_child);
				tmq = mq_open(cQueue, O_CREAT|O_WRONLY, MODE, &mqattr);
				
				//convert the #child into a char and send via msg queue
				sprintf(msgbuf, "%d", child_counter++);
				mq_send(tmq, msgbuf, sizeof(msgbuf), PRIO);
				sleep(1);
			}
		}

	}
*/

return EXIT_SUCCESS;

}

void sigint(int signum) {
	ready = 1;
}



