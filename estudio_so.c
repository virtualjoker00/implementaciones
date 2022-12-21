#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <iostream>


// mutex use example
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
int count = 0;

void *thread1(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex);
        count++;
        cout << "thread1: " << count << endl;
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void *thread2(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex);
        count++;
        cout << "thread2: " << count << endl;
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

int main()
{
    pthread_t tid1, tid2; // thread id
    pthread_create(&tid1, NULL, thread1, NULL); // create thread1, thread1 function is thread1, no parameters
    pthread_create(&tid2, NULL, thread2, NULL); // create thread2, thread2 function is thread2, no parameters
    pthread_join(tid1, NULL); // wait for thread1 to end
    pthread_join(tid2, NULL); // wait for thread2 to end
    return 0;
}

// semaphore use example

sem_t sem;

void *thread1(void *arg)
{
    while (1)
    {
        sem_wait(&sem);
        count++;
        cout << "thread1: " << count << endl;
        sem_post(&sem);
        sleep(1);
    }
}

void *thread2(void *arg)
{
    while (1)
    {
        sem_wait(&sem);
        count++;
        cout << "thread2: " << count << endl;
        sem_post(&sem);
        sleep(1);
    }
}

int main()
{
    sem_init(&sem, 0, 1); // initialize semaphore, 0 means semaphore is shared between threads, 1 means semaphore is initialized to 1
    pthread_t tid1, tid2;
    pthread_create(&tid1, NULL, thread1, NULL);
    pthread_create(&tid2, NULL, thread2, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    sem_destroy(&sem);
    return 0;
}

// condition variable use example

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
int count = 0;

void *thread1(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex); 
        count++;
        cout << "thread1: " << count << endl; 
        pthread_cond_signal(&cond); // send signal to thread2
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void *thread2(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex);
        while (count == 0) // if count is 0, wait for signal
        {
            pthread_cond_wait(&cond, &mutex); 
        }
        count--;
        cout << "thread2: " << count << endl; // if count is not 0, print count
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

int main()
{
    pthread_t tid1, tid2;
    pthread_create(&tid1, NULL, thread1, NULL);
    pthread_create(&tid2, NULL, thread2, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    return 0; 
}

// synchronization use example 
// classical producer-consumer problem

#define MAX 10
int buffer[MAX];
int in = 0;
int out = 0;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void *producer(void *arg)
{
    int i;
    for (i = 0; i < 100; i++)
    {
        pthread_mutex_lock(&mutex);
        while ((in + 1) % MAX == out) // if buffer is full, wait for signal
        {
            pthread_cond_wait(&cond, &mutex); 
        }
        buffer[in] = i;
        cout << "producer: " << i << endl;
        in = (in + 1) % MAX;
        pthread_cond_signal(&cond); // send signal to consumer
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void *consumer(void *arg)
{
    int i;
    for (i = 0; i < 100; i++)
    {
        pthread_mutex_lock(&mutex);
        while (in == out) // if buffer is empty, wait for signal
        {
            pthread_cond_wait(&cond, &mutex);
        }
        int data = buffer[out];
        cout << "consumer: " << data << endl;
        out = (out + 1) % MAX;
        pthread_cond_signal(&cond); // send signal to producer
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

int main()
{
    pthread_t tid1, tid2;
    pthread_create(&tid1, NULL, producer, NULL);
    pthread_create(&tid2, NULL, consumer, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    return 0;
}

// classical reader-writer problem

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
int readcount = 0;

void *reader(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex);
        readcount++;
        if (readcount == 1) // if it is the first reader, wait for signal
        {
            pthread_cond_wait(&cond, &mutex);
        }
        pthread_mutex_unlock(&mutex);
        cout << "reader: " << readcount << endl;
        pthread_mutex_lock(&mutex);
        readcount--;
        if (readcount == 0) // if it is the last reader, send signal to writer
        {
            pthread_cond_signal(&cond);
        }
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void *writer(void *arg)
{
    while (1)
    {
        pthread_mutex_lock(&mutex);
        while (readcount != 0) // if there are readers, wait for signal
        {
            pthread_cond_wait(&cond, &mutex);
        }
        cout << "writer: " << readcount << endl;
        pthread_cond_signal(&cond); // send signal to reader
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

int main()
{
    pthread_t tid1, tid2;
    pthread_create(&tid1, NULL, reader, NULL);
    pthread_create(&tid2, NULL, writer, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    return 0;
}

// classical dining philosopher problem

#define N 5
#define LEFT (i + N - 1) % N
#define RIGHT (i + 1) % N
#define THINKING 0
#define HUNGRY 1
#define EATING 2
int state[N];
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

void *philosopher(void *arg)
{
    int i = (int)arg; // philosopher id
    while (1)
    {
        pthread_mutex_lock(&mutex); 
        state[i] = HUNGRY; 
        cout << "philosopher " << i << " is hungry" << endl;
        test(i); // if it can eat, eat
        while (state[i] != EATING) // if it is not eating, wait for signal
        {
            pthread_cond_wait(&cond, &mutex);
        }
        pthread_mutex_unlock(&mutex); 
        cout << "philosopher " << i << " is eating" << endl;
        sleep(1);
        pthread_mutex_lock(&mutex);
        state[i] = THINKING;
        cout << "philosopher " << i << " is thinking" << endl;
        test(LEFT); // if left philosopher can eat, eat
        test(RIGHT); // if right philosopher can eat, eat
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
}

void test(int i)
{
    if (state[i] == HUNGRY && state[LEFT] != EATING && state[RIGHT] != EATING) // if it is hungry and left and right philosophers are not eating, eat
    {
        state[i] = EATING; 
        pthread_cond_signal(&cond); // send signal to philosopher
    }
}

int main()
{
    pthread_t tid[N];
    for (int i = 0; i < N; i++)
    {
        pthread_create(&tid[i], NULL, philosopher, (void *)i); // create philosopher threads
    }
    for (int i = 0; i < N; i++)
    {
        pthread_join(tid[i], NULL); // wait for philosopher threads
    }
    return 0;
}
