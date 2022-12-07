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
    condicion1 =. (elfo11 <: elfo21) *. (elfo21 <: elfo12)
    condicion2 =. (elfo11 <: elfo22) *. (elfo22<: elfo12)
    condicion3 =. (elfo21 <: elfo11) *. (elfo11<: elfo22)
    condicion4 =. (elfo21 <: elfo12) *. (elfo12<: elfo22)
    condicion =. condicion1 +. condicion2 +. condicion3 +. condicion4
    if.  condicion do.
      res =. >: res
    end.
end.
res
)

loop matriz
