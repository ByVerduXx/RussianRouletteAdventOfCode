# Para el formato de salida
options(width = 2000)

# Lenguajes y participantes
# NO QUITAR NINGUNO
languages <- c("JS", "Python", "Java", "C", "C++", "C#", "Rust", "R", "Go", "Swift", "Ruby", "PHP", "Shell", "Scala", "J", "Kotlin", "Objective-C", "Groovy", "Elixir", "Lua", "DM", "Perl", "Dart", "Clojure", "PowerShell", "CoffeeScript", "Haskell", "OCaml", "Lisp", "Vim Script", "Jsonnet", "Erlang", "Puppet", "Julia", "Limbo", "Matlab", "Typescript", "Fortran", "F#", "VisualBasic", "NASM", "SQL", "Vala", "Nix", "Crystal", "Roff", "Raku", "Prolog", "PureScript", "Objective C++")
participants <- c("Edu", "Jesus", "Alex", "Dani", "Checo", "Divy", "Oscar", "Hugo", "Padilla")

# Eleccion de lenguajes para todos los participantes, todos los dias
set.seed(42)
df <- as.data.frame(sapply(participants, function(x) sample(languages, 25, TRUE)))

# Elecciones del dia 1 y 2 (las calculamos de otra forma así que las forzamos)
df[1:2, 1:5] <- matrix(c("Fortran", "F#", "PureScript", "Groovy", "PowerShell", "PureScript", "Kotlin", "Perl", "x86-64 ASM", "Vim Script"), 2, 5)

# Dias que mostrar
days <- 1:9

# Participantes ordenados por numero de problemas resueltos
# (solo si han resuelto al menos 1)
solved <- c(7, 4, 7, 6, 2, 0, 5, 0, 0)
orderedsolved <- order(solved)
selectedsolved <- rev(orderedsolved[solved[orderedsolved] > 0])

# Elecciones para los dias y participantes seleccionados
df[days, selectedsolved]
