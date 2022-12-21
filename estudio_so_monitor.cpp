// monitor use example (C++)
#include <iostream>
#include <pthread.h>
#include <unistd.h>

using namespace std;

class Monitor
{
public:
    Monitor()
    {
        pthread_mutex_init(&mutex, NULL);
        pthread_cond_init(&cond, NULL);
    }

    ~Monitor()
    {
        pthread_mutex_destroy(&mutex);
        pthread_cond_destroy(&cond);
    }

    void lock()
    {
        pthread_mutex_lock(&mutex);
    }

    void unlock()
    {
        pthread_mutex_unlock(&mutex);
    }

    void wait()
    {
        pthread_cond_wait(&cond, &mutex);
    }

    void signal()
    {
        pthread_cond_signal(&cond);
    }

    void broadcast() // wake up all threads
    {
        pthread_cond_broadcast(&cond);
    }

private:
    pthread_mutex_t mutex;
    pthread_cond_t cond;
};

Monitor monitor;
int count = 0;

void* thread_func(void* arg)
{
    int id = (int)arg; 
    while (true)
    {
        monitor.lock(); 
        while (count % 3 != id)
        {
            monitor.wait(); // wait for signal
        }
        cout << "thread " << id << ": " << count << endl; 
        count++;
        monitor.broadcast(); // wake up all threads
        monitor.unlock(); 
        sleep(1);
    }
    return NULL;
}

int main()
{
    pthread_t threads[3];
    for (int i = 0; i < 3; i++)
    {
        pthread_create(&threads[i], NULL, thread_func, (void*)i); // create thread, pass i as argument, null as default attributes, null as default return value, thread_func as function to run
    for (int i = 0; i < 3; i++)
    {
        pthread_join(threads[i], NULL); // wait for thread to finish
    }
    return 0;
}
}

