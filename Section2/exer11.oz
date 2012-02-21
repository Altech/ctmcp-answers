% 11.相互再帰(mutual recursion)
fun {IsEven X}
   if X==0 then true else {IsOdd X-1} end
end
fun {IsOdd X}
   if X==0 then false else {IsEven X-1} end
end

/*
([({IsEven X},{X=>x1})],{x1=N1})
について、帰納段階を進めると、
([({IsOdd X},{X=>x2})],{x2=N2})
となって、意味スタックも格納域も大きくならない。逆も同様。
この過程を繰り返すため、一定の意味スタックと格納域で実行出来ることがわかる。
*/