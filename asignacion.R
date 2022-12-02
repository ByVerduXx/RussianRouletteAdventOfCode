# Lenguajes y participantes
# NO QUITAR NINGUNO
languages <- c("JS", "Python", "Java", "C", "C++", "C#", "Rust", "R", "Go", "Swift", "Ruby", "PHP", "Shell", "Scala", "J", "Kotlin", "Objective-C", "Groovy", "Elixir", "Lua", "DM", "Perl", "Dart", "Clojure", "PowerShell", "CoffeeScript", "Haskell", "OCaml", "Lisp", "Vim Script", "Jsonnet", "Erlang", "Puppet", "Julia", "SmallTalk", "Matlab", "WebAssembly", "Fortran", "F#", "VisualBasics", "x64-86 asm", "ABAP", "Vala", "Nix", "Crystal", "Roff", "Perl 6", "FreeMaker", "PureScript", "Objective C++")
participants <- c("Edu", "Jesus", "Alex", "Dani", "Checo", "Divy", "Oscar", "Hugo")

# Eleccion de lenguajes para todos los participantes, todos los dias
set.seed(42)
df <- as.data.frame(sapply(participants, function(x) sample(languages, 25, TRUE)))

# Elecciones del dia 1 y 2 (las calculamos de otra forma así que las forzamos)
df[1:2, 1:5] <- matrix(c("Fortran", "F#", "PureScript", "Groovy", "PowerShell", "PureScript", "Kotlin", "Perl", "x64-86 asm", "Vim Script"), 2, 5)

# Elecciones para el dia n
n <- 1:2
df[n, ]
