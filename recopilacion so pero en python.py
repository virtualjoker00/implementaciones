# ejemplos de mutex, semaforo, variables de condicion, etc

# mutex ejemplo generico

import threading
import time
import random

class MiHilo(threading.Thread):
    def __init__(self, nombre, mutex):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.mutex = mutex

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            print("Soy el hilo ", self.nombre, " y estoy adquiriendo el mutex")
            time.sleep(random.randint(1, 3))
            print("Soy el hilo ", self.nombre, " y estoy liberando el mutex")
            self.mutex.release()

mutex = threading.Lock()
hilo1 = MiHilo("hilo1", mutex)
hilo2 = MiHilo("hilo2", mutex)
hilo3 = MiHilo("hilo3", mutex)
hilo1.start()
hilo2.start()
hilo3.start()

# semaforo ejemplo generico

import threading
import time
import random

class MiHilo(threading.Thread):
    def __init__(self, nombre, semaforo):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.semaforo = semaforo

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.semaforo.acquire()
            print("Soy el hilo ", self.nombre, " y estoy adquiriendo el semaforo")
            time.sleep(random.randint(1, 3))
            print("Soy el hilo ", self.nombre, " y estoy liberando el semaforo")
            self.semaforo.release()

semaforo = threading.Semaphore(2)
hilo1 = MiHilo("hilo1", semaforo)
hilo2 = MiHilo("hilo2", semaforo)
hilo3 = MiHilo("hilo3", semaforo)
hilo1.start()
hilo2.start()
hilo3.start()

# variables de condicion ejemplo generico

import threading
import time
import random

class MiHilo(threading.Thread):
    def __init__(self, nombre, condicion):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.condicion = condicion

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.condicion.acquire()
            print("Soy el hilo ", self.nombre, " y estoy adquiriendo la condicion")
            time.sleep(random.randint(1, 3))
            print("Soy el hilo ", self.nombre, " y estoy liberando la condicion")
            self.condicion.notify()
            self.condicion.release()

condicion = threading.Condition()
hilo1 = MiHilo("hilo1", condicion)
hilo2 = MiHilo("hilo2", condicion)
hilo3 = MiHilo("hilo3", condicion)
hilo1.start()
hilo2.start()
hilo3.start()

# mutex con variables de condicion

import threading
import time
import random

class MiHilo(threading.Thread):
    def __init__(self, nombre, mutex, condicion):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.mutex = mutex
        self.condicion = condicion

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            print("Soy el hilo ", self.nombre, " y estoy adquiriendo el mutex")
            time.sleep(random.randint(1, 3))
            print("Soy el hilo ", self.nombre, " y estoy liberando el mutex")
            self.condicion.notify()
            self.mutex.release()

mutex = threading.Lock()
condicion = threading.Condition()
hilo1 = MiHilo("hilo1", mutex, condicion)
hilo2 = MiHilo("hilo2", mutex, condicion)
hilo3 = MiHilo("hilo3", mutex, condicion)
hilo1.start()
hilo2.start()
hilo3.start()


# productor consumidor

import threading
import time
import random

class Productor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            if len(self.buffer) == 10:
                print("Buffer lleno, no se puede producir")
                self.lleno.wait()
            self.buffer.append(1)
            print("Se produjo un elemento, buffer: ", len(self.buffer))
            self.vacio.notify()
            self.mutex.release()

class Consumidor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            if len(self.buffer) == 0:
                print("Buffer vacio, no se puede consumir")
                self.vacio.wait()
            self.buffer.pop()
            print("Se consumio un elemento, buffer: ", len(self.buffer))
            self.lleno.notify()
            self.mutex.release()

buffer = []
mutex = threading.Lock()
lleno = threading.Condition(mutex)
vacio = threading.Condition(mutex)

p1 = Productor("p1", buffer, mutex, lleno, vacio)
p2 = Productor("p2", buffer, mutex, lleno, vacio)
c1 = Consumidor("c1", buffer, mutex, lleno, vacio)
c2 = Consumidor("c2", buffer, mutex, lleno, vacio)

p1.start()
p2.start()
c1.start()
c2.start()

# productor consumidor con semaforos

import threading
import time
import random

class Productor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            if len(self.buffer) == 10:
                print("Buffer lleno, no se puede producir")
                self.lleno.wait()
            self.buffer.append(1)
            print("Se produjo un elemento, buffer: ", len(self.buffer))
            self.vacio.release()
            self.mutex.release()

class Consumidor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.vacio.acquire()
            self.mutex.acquire()
            if len(self.buffer) == 0:
                print("Buffer vacio, no se puede consumir")
                self.lleno.wait()
            self.buffer.pop()
            print("Se consumio un elemento, buffer: ", len(self.buffer))
            self.lleno.release()
            self.mutex.release()

buffer = []
mutex = threading.Lock()
lleno = threading.Semaphore(0)
vacio = threading.Semaphore(10)

p1 = Productor("p1", buffer, mutex, lleno, vacio)
p2 = Productor("p2", buffer, mutex, lleno, vacio)
c1 = Consumidor("c1", buffer, mutex, lleno, vacio)
c2 = Consumidor("c2", buffer, mutex, lleno, vacio)

p1.start()
p2.start()
c1.start()
c2.start()

# productor consumidor con semaforos y variables de condicion

import threading
import time
import random

class Productor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.mutex.acquire()
            if len(self.buffer) == 10:
                print("Buffer lleno, no se puede producir")
                self.lleno.wait()
            self.buffer.append(1)
            print("Se produjo un elemento, buffer: ", len(self.buffer))
            self.vacio.release()
            self.mutex.release()

class Consumidor(threading.Thread):
    def __init__(self, nombre, buffer, mutex, lleno, vacio):
        threading.Thread.__init__(self)
        self.nombre = nombre
        self.buffer = buffer
        self.mutex = mutex
        self.lleno = lleno
        self.vacio = vacio

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.vacio.acquire()
            self.mutex.acquire()
            if len(self.buffer) == 0:
                print("Buffer vacio, no se puede consumir")
                self.lleno.wait()
            self.buffer.pop()
            print("Se consumio un elemento, buffer: ", len(self.buffer))
            self.lleno.notify()
            self.mutex.release()

buffer = []
mutex = threading.Lock()
lleno = threading.Condition(mutex)
vacio = threading.Semaphore(10)

p1 = Productor("p1", buffer, mutex, lleno, vacio)
p2 = Productor("p2", buffer, mutex, lleno, vacio)
c1 = Consumidor("c1", buffer, mutex, lleno, vacio)
c2 = Consumidor("c2", buffer, mutex, lleno, vacio)

p1.start()
p2.start()
c1.start()
c2.start()

# dining philosopher problem

import threading
import random
import time

#inheriting threading class in Thread module
class Philosopher(threading.Thread):
    running = True  #used to check if everyone is finished eating

 #Since the subclass overrides the constructor, it must make sure to invoke the base class constructor (Thread.__init__()) before doing anything else to the thread.
    def __init__(self, index, forkOnLeft, forkOnRight):
        threading.Thread.__init__(self)
        self.index = index
        self.forkOnLeft = forkOnLeft
        self.forkOnRight = forkOnRight

    def run(self):
        while(self.running):
            # Philosopher is thinking (but really is sleeping).
            time.sleep(30)
            print ('Philosopher %s is hungry.' % self.index)
            self.dine()

    def dine(self):
        # if both the semaphores(forks) are free, then philosopher will eat
        fork1, fork2 = self.forkOnLeft, self.forkOnRight
        while self.running:
            fork1.acquire() # wait operation on left fork
            locked = fork2.acquire(False) 
            if locked: break #if right fork is not available leave left fork
            fork1.release()
            print ('Philosopher %s swaps forks.' % self.index)
            fork1, fork2 = fork2, fork1
        else:
            return
        self.dining()
        #release both the fork after dining
        fork2.release()
        fork1.release()
 
    def dining(self):			
        print ('Philosopher %s starts eating. '% self.index)
        time.sleep(30)
        print ('Philosopher %s finishes eating and leaves to think.' % self.index)

def main():
    forks = [threading.Semaphore() for n in range(5)] #initialising array of semaphore i.e forks

    #here (i+1)%5 is used to get right and left forks circularly between 1-5
    philosophers= [Philosopher(i, forks[i%5], forks[(i+1)%5])
            for i in range(5)]

    Philosopher.running = True
    for p in philosophers: p.start()
    time.sleep(100)
    Philosopher.running = False
    print ("Now we're finishing.")
 

if __name__ == "__main__":
    main()

# reader writer problem

import threading
import time
import random

class Reader(threading.Thread):
    def __init__(self, name, reader_lock, writer_lock):
        threading.Thread.__init__(self)
        self.name = name
        self.reader_lock = reader_lock
        self.writer_lock = writer_lock

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.reader_lock.acquire()
            self.writer_lock.acquire()
            print("Reader %s is reading" % self.name)
            self.writer_lock.release()
            self.reader_lock.release()

class Writer(threading.Thread):
    def __init__(self, name, reader_lock, writer_lock):
        threading.Thread.__init__(self)
        self.name = name
        self.reader_lock = reader_lock
        self.writer_lock = writer_lock

    def run(self):
        while True:
            time.sleep(random.randint(1, 3))
            self.writer_lock.acquire()
            print("Writer %s is writing" % self.name)
            self.writer_lock.release()

reader_lock = threading.Lock()
writer_lock = threading.Lock()

r1 = Reader("r1", reader_lock, writer_lock)
r2 = Reader("r2", reader_lock, writer_lock)
r3 = Reader("r3", reader_lock, writer_lock)
w1 = Writer("w1", reader_lock, writer_lock)
w2 = Writer("w2", reader_lock, writer_lock)

r1.start()
r2.start()
r3.start()
w1.start()
w2.start()



