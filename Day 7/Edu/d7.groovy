// Examinar el árbol de directorios de un sistema de ficheros
def printdir(dir, indent = 0) {
  println ' ' * indent + '- ' + dir.name + ' (' + dir.type + (dir.type == 'file' ? ', size=' + dir.size : '' ) + ')'
  if (dir.type == 'dir') {
    dir.children.each { printdir(it, indent + 2) }
  }
}

// Computar los tamaños de los directorios en un sistema de archivos
def computedirsize(dir) {
  if (dir.size != 0) {
    dir.size
  } else {
    size = dir.children.collect { computedirsize(it) }.sum()
    dir.size = size
    size
  }
}

// Extraer los directorios con tamaño mayor a un umbral
def getdirsbysize(dir, threshold, greater = false) {
  if (dir.type == 'file') {
    []
  } else if ((dir.size > threshold && !greater) || (dir.size < threshold && greater)) {
    [] + dir.children.collect { getdirsbysize(it, threshold, greater) }.sum()
  } else {
    [dir] + dir.children.collect { getdirsbysize(it, threshold, greater) }.sum()
  }
}

// Directorio raíz
def root = [
  parent : null,
  name : '/',
  size : 0,
  type : 'dir',
  children : []
]
root.parent = root

// Leemos la entrada estándar
def reader = System.in.newReader()

// Centinela para saber si se debe leer la siguiente línea
def read = true

// Estado actual del parser (command, output)
def state = 'command'

// Directorio actual
def pwd = root

// Línea actual
def str = ""
while (true) {
  // Leemos la siguiente línea si no se ha leído ya
  if (read) {
    str = reader.readLine()
    // println str
  } else {
    read = true
  }

  // Si la línea está vacía, salimos
  if (str == null || str == '') {
    break
  }

  // Detectar el estado actual
  switch (state) {
    // En el estado command, leemos el siguiente comando (cd, ls)
    case 'command':
      switch (str[0..3]) {
        // Si es un comando cd, cambiamos el directorio actual
        case '$ cd':
          def name = str[5..-1]
          // Si el nombre es .., subimos un nivel
          if (name == '..') {
            pwd = pwd.parent
          }
          // Si el nombre es /, volvemos al directorio raíz
          else if (name == '/') {
            pwd = root
          }
          // Si el nombre es un directorio, nos movemos a él
          else {
            for (child in pwd.children) {
              if (child.name == name) {
                pwd = child
                break
              }
            }
          }
          break
        // Si es un comando ls, nos preparamos para leer el output
        case '$ ls':
          state = 'output'
          break
      }
      break
    // En el estado output, leemos el output del comando ls
    case 'output':
      // Si la línea empieza por $, es un nuevo comando 
      if (str[0] == '$') {
        state = 'command'
        read = false
      }
      // Si la linea no está vacía, es un directorio o fichero nuevo
      else if (str != '') {
        def (type, name) = str.tokenize(' ')
        def file = [
          parent : pwd,
          name : name,
          size : (type == 'dir' ? 0 : (type as Integer)),
          type : (type == 'dir' ? 'dir' : 'file'),
          children : (type == 'dir' ? [] : null)
        ]
        pwd.children << file
      }
      break
  }
}

// Imprimir el árbol de directorios
printdir(root)

// Computar los tamaños de los directorios
computedirsize(root)

// --- Part One ---
println getdirsbysize(root, 100000).collect { it.size }.sum()

// --- Part Two ---
def needed = 30000000 - 70000000 + root.size
if (needed < 0) needed = 0
println Collections.min(getdirsbysize(root, needed, true).collect { it.size })
