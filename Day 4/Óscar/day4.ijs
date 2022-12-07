fn =. < 'D:/PyCharm/AOC/output4.txt'
data =. freads fn
concatIntegers  =. ,&'x'@,&.":


separado =.  ;: data
lista =. > ((i.(#separado)%2)*2) {separado

n_lista =. #lista 
n_2 =. n_lista % 4

lista_2 =. concatIntegers each/|:lista
matriz =: 1000 4 $ > lista_2

loop =: monad : 0
res =. 0
for_i. i.1000 do.
    fila =. i { matriz
    elfo11 =. 0 {fila
    elfo12 =. 1 {fila
    elfo21 =. 2 {fila
    elfo22 =. 3 {fila 
    condicion1 =. (elfo11 >: elfo21) *. (elfo12 <: elfo22)
    condicion2 =. (elfo21 >: elfo11) *. (elfo22 <: elfo12)
    if. condicion1 +. condicion2 do.
      res =. >: res
    end.
end.
res
)

loop matriz
