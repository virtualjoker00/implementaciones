#### super biblia de códigos  ####

### estructuras de datos ###
# listas y sus métodos
print("arreglos: ")
lista = [1, 2, 3, 4, 5]
lista.append(6)
print(lista)
lista.insert(0, 0)
print(lista)
lista.remove(0)
print(lista)
lista.pop(0)
print(lista)
lista.reverse()
print(lista)
lista.sort()
print(lista)
lista.clear()
print(lista)

# lista simple con sus métodos
class nodo ():
    def __init__(self, value):
        self.value = value
        self.next = None

class lista ():
    def __init__(self):
        self.root = None
        self.size = 0
    def insert (self, value):
        root = self.root
        newNode = nodo(value)
        if root == None:
            self.root = newNode
            self.size += 1
        else:
            # buscar nextNode
            nextNode = self.root
            while nextNode.next:
                nextNode = nextNode.next
            nextNode.next = newNode
    def printList(self):
        nextNode = self.root
        while nextNode:
            print(nextNode.value)
            nextNode = nextNode.next
    def delete(self,value):
        nextNode = self.root
        while nextNode:
            if nextNode.value == value:
                nextNode = nextNode.next
            else:
                nextNode = nextNode.next
    def search(self, value):
        nextNode = self.root
        while nextNode:
            if nextNode.value == value:
                return True
            else:
                nextNode = nextNode.next
        return False

    
# insertar valores de arreglo en lista 

numeros = [1, 2, 3, 4, 5]
myList = lista()
for i in numeros:
    myList.insert(i)
print("Lista simple: ")
myList.printList()

# lista doble con sus métodos
class nodo_doble ():
    def __init__(self, value):
        self.value = value
        self.prev = None
        self.next = None

class lista_doble ():
    def __init__(self):
        self.root = None
        self.size = 0
    # Given a reference to the head of a list and an
    # integer, inserts a new node on the front of list
    def push(self, value):
        newNode = nodo_doble(value)
        newNode.next = self.root
        newNode.prev = None
        if self.root is not None:
            self.root.prev = newNode
        self.root = newNode
        self.size += 1
    # Given a node as prev_node, insert a new node after
    # the given node
    def insertAfter(self, prev_node, value):
        if prev_node is None:
            return
        newNode = nodo_doble(value)
        newNode.next = prev_node.next
        prev_node.next = newNode
        newNode.prev = prev_node
        if newNode.next is not None:
            newNode.next.prev = newNode
        self.size += 1
    # Given a reference to the head of DLL and integer,
    # appends a new node at the end
    def append(self, value):
        newNode = nodo_doble(value)
        newNode.next = None
        if self.root is None:
            newNode.prev = None
            self.root = newNode
            return
        last = self.root
        while last.next is not None:
            last = last.next
        last.next = newNode
        newNode.prev = last
        self.size += 1
    # This function prints contents of linked list
    # starting from the given node
    def printList(self, node):
        print("Traversal in forward direction")
        while node is not None:
            print(" % d" % (node.value))
            last = node
            node = node.next
        print("Traversal in reverse direction")
        while last is not None:
            print(" % d" % (last.value))
            last = last.prev
    # Given a reference to the head of a list and a key,
    # deletes the first occurrence of key in linked list
    def deleteNode(self, value):
        temp = self.root
        if temp is not None:
            if temp.value == value:
                self.root = temp.next
                temp = None
                return
        while temp is not None:
            if temp.value == value:
                break
            prev = temp
            temp = temp.next
        if temp == None:
            return
        prev.next = temp.next
        temp = None
        self.size -= 1

# insertar valores de arreglo en lista doble
numeros = [34,5,657,3,4]
myList = lista_doble()
for i in numeros:
    myList.append(i)
print("Lista doble: ")
myList.printList(myList.root)

# pilas y sus métodos (stack)
print("pilas: ")
pila = [1, 2, 3, 4, 5]
pila.append(6)
pila.pop() # elimina el último elemento

# colas y sus métodos (queue)
print("colas: ")
cola = [1, 2, 3, 4, 5]
cola.append(6)
cola.pop(0) # elimina el primer elemento

# diccionarios y sus métodos
print("diccionarios: ")
diccionario = { "nombre": "Juan", "edad": 25, "cursos": ["Python", "Django"] }
print(diccionario)
print(diccionario["nombre"])
print(diccionario["edad"])
print(diccionario["cursos"])
print(diccionario.get("nombre"))
print(diccionario.get("edad"))
print(diccionario.get("cursos"))
diccionario["nombre"] = "Pedro"
print(diccionario)
diccionario["apellido"] = "Perez"
print(diccionario)
diccionario.pop("apellido")
print(diccionario)
diccionario.popitem()
print(diccionario)
diccionario.clear()
print(diccionario)

# arból binario con sus métodos
class nodo_arbol ():
    def __init__(self, value, left=None, right=None):
        self.data = value
        self.left = left
        self.right = right
    
class arbol_binario ():
    def __init__(self):
        self.root = None
    def insert(self, value):
        if self.root == None:
            self.root = nodo_arbol(value, None, None)
        else:
            self._insert(value, self.root)
    def _insert(self, value, cur_node):
        if value < cur_node.data:
            if cur_node.left == None:
                cur_node.left = nodo_arbol(value)
            else:
                self._insert(value, cur_node.left)
        elif value > cur_node.data:
            if cur_node.right == None:
                cur_node.right = nodo_arbol(value)
            else:
                self._insert(value, cur_node.right)
        else:
            print("El valor ya existe en el árbol")
    def print_tree(self):
        if self.root != None:
            self._print_tree(self.root)
    def _print_tree(self, cur_node):
        if cur_node != None:
            self._print_tree(cur_node.left)
            print(str(cur_node.data))
            self._print_tree(cur_node.right)
    def height(self):
        if self.root != None:
            return self._height(self.root, 0)
        else:
            return 0
    def _height(self, cur_node, cur_height):
        if cur_node == None:
            return cur_height
        left_height = self._height(cur_node.left, cur_height + 1)
        right_height = self._height(cur_node.right, cur_height + 1)
        return max(left_height, right_height)
    def search(self, value):
        if self.root != None:
            return self._search(value, self.root)
        else:
            return False
    def _search(self, value, cur_node):
        if value == cur_node.data:
            return True
        elif value < cur_node.data and cur_node.left != None:
            return self._search(value, cur_node.left)
        elif value > cur_node.data and cur_node.right != None:
            return self._search(value, cur_node.right)
        return False
    
tree = arbol_binario()
tree.insert(5)
tree.insert(3)
tree.insert(7)
tree.insert(2)
tree.insert(4)
tree.insert(6)
tree.insert(8)
tree.print_tree()
print("La altura del árbol es: ", tree.height())
print("El valor 7 se encuentra en el árbol: ", tree.search(7))
print("El valor 9 se encuentra en el árbol: ", tree.search(9))

# algoritmos de ordenamiento
# bubble sort: ordenamiento de burbuja
# el algoritmo de ordenamiento de burbuja compara cada elemento de la lista con el siguiente,
# si el elemento actual es mayor que el siguiente, los intercambia.
# de esta forma, el elemento mayor va a la parte superior de la lista.
# el algoritmo repite este proceso hasta que no se requieran más intercambios,
# lo que significa que la lista está ordenada.
# complejidad: O(n^2)
def bubbleSort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1] :
                arr[j], arr[j+1] = arr[j+1], arr[j]
arr = [64, 34, 25, 12, 22, 11, 90]
bubbleSort(arr)
print ("BubbleSort: ")
print ("Lista ordenada: ")
for i in range(len(arr)):
    print ("%d" %arr[i]),
# output: 11 12 22 25 34 64 90

# selection sort: ordenamiento por selección
# el algoritmo de ordenamiento por selección busca el elemento más pequeño en una lista
# y lo intercambia con el elemento en la primera posición, luego busca el segundo elemento más pequeño
# y lo intercambia con el elemento en la segunda posición, y así sucesivamente.
# complejidad: O(n^2)
def selectionSort(arr):
    for i in range(len(arr)):
        min_idx = i
        for j in range(i+1, len(arr)):
            if arr[min_idx] > arr[j]:
                min_idx = j
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
arr = [64, 25, 12, 22, 11]
selectionSort(arr)
print ("SelectionSort: ")
print ("Lista ordenada: ")
for i in range(len(arr)):
    print("%d" %arr[i]),
# output: 11 12 22 25 64

# insertion sort: ordenamiento por inserción
# el algoritmo de ordenamiento por inserción funciona similar a como ordenaríamos las cartas en la mano.
# tomamos una carta de la baraja y la insertamos en la posición correcta en la mano ordenada.
# repetimos este proceso hasta que no queden cartas en la baraja.
# complejidad: O(n^2)
def insertionSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1
        while j >=0 and key < arr[j] :
                arr[j+1] = arr[j]
                j -= 1
        arr[j+1] = key
arr = [12, 11, 13, 5, 6]
insertionSort(arr)
print ("InsertionSort: ")
print ("Lista ordenada: ")
for i in range(len(arr)):
    print ("%d" %arr[i]),
# output: 5 6 11 12 13

# merge sort: ordenamiento por mezcla
# el algoritmo de ordenamiento por mezcla divide recursivamente una lista en mitades hasta que cada mitad
# contiene un solo elemento y luego combina las mitades en una lista ordenada.
# complejidad: O(n log n)
def mergeSort(arr):
    if len(arr) >1:
        mid = len(arr)//2
        L = arr[:mid]
        R = arr[mid:]
        mergeSort(L)
        mergeSort(R)
        i = j = k = 0
        # Copy data to temp arrays L[] and R[]
        # Comparing the first elements of the two subarrays
        # and adding the smaller one in the main array
        # and then moving to the next element in the subarray
        # that was added to the main array
        # and repeating the process until one of the subarrays is empty
        # and then adding the remaining elements of the other subarray
        # to the main array
        while i < len(L) and j < len(R):
            if L[i] < R[j]:
                arr[k] = L[i]
                i+=1
            else:
                arr[k] = R[j]
                j+=1
            k+=1
        # Checking if any element was left
        # Copy the remaining elements of L[], if there
        # are any
        while i < len(L):
            arr[k] = L[i]
            i+=1
            k+=1
        # Checking if any element was left
        while j < len(R):
            arr[k] = R[j]
            j+=1
            k+=1
arr = [12, 11, 13, 5, 6, 7]
mergeSort(arr)
print ("MergeSort: ")
print ("Lista ordenada: ")
for i in range(len(arr)):
    print ("%d" %arr[i]),
# output: 5 6 7 11 12 13

# quick sort: ordenamiento rápido
# el algoritmo de ordenamiento rápido es un algoritmo de división y conquista.
# el algoritmo selecciona un elemento como pivote y particiona la lista alrededor del pivote seleccionado.
# complejidad: O(n log n), en el peor caso O(n^2) (cuando el pivote es el elemento más grande o más pequeño)
def partition(arr,low,high):
    i = ( low-1 )         # index of smaller element
    pivot = arr[high]     # pivot
    for j in range(low , high):
        # If current element is smaller than or
        # equal to pivot
        if   arr[j] <= pivot:
            # increment index of smaller element
            i = i+1
            arr[i],arr[j] = arr[j],arr[i]
    arr[i+1],arr[high] = arr[high],arr[i+1]
    return ( i+1 )
# Function to do Quick sort
def quickSort(arr,low,high):
    if low < high:
        # pi is partitioning index, arr[p] is now
        # at right place
        pi = partition(arr,low,high)
        # Separately sort elements before
        # partition and after partition
        quickSort(arr, low, pi-1)
        quickSort(arr, pi+1, high)

arr = [10, 7, 8, 9, 1, 5]
n = len(arr)
quickSort(arr,0,n-1)
print ("QuickSort: ")
print ("Lista ordenada: ")
for i in range(n):
    print ("%d" %arr[i]),
# output: 1 5 7 8 9 10

# heap sort: ordenamiento por montículo
# el algoritmo de ordenamiento por montículo es un algoritmo de ordenamiento de comparación basado en el
# montículo binario.
# complejidad: O(n log n)
def heapify(arr, n, i):
    largest = i  # Initialize largest as root
    l = 2 * i + 1     # left = 2*i + 1
    r = 2 * i + 2     # right = 2*i + 2
    # See if left child of root exists and is
    # greater than root
    if l < n and arr[i] < arr[l]:
        largest = l
    # See if right child of root exists and is
    # greater than root
    if r < n and arr[largest] < arr[r]:
        largest = r
    # Change root, if needed
    if largest != i:
        arr[i],arr[largest] = arr[largest],arr[i]  # swap
        # Heapify the root.
        heapify(arr, n, largest)
# The main function to sort an array of given size
def heapSort(arr):
    n = len(arr)
    # Build a maxheap.
    # Since last parent will be at ((n//2)-1) we can start at that location.
    for i in range(n // 2 - 1, -1, -1):
        heapify(arr, n, i)
    # One by one extract elements
    for i in range(n-1, 0, -1):
        arr[i], arr[0] = arr[0], arr[i]   # swap
        heapify(arr, i, 0)
arr = [ 12, 11, 13, 5, 6, 7]
heapSort(arr)
n = len(arr)
print ("HeapSort: ")
print ("Lista ordenada: ")
for i in range(n):
    print ("%d" %arr[i]),
# output: 5 6 7 11 12 13

