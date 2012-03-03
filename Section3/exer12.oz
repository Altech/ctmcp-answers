% 12.リストの平坦化の計算量
fun {Flatten Ls}
   case Ls
   of nil then nil
   [] X|Xr andthen {IsList X} then {Append {Flatten X} {Flatten Xr}}
   [] X|Xr then X|{Flatten Xr}
   end
end

/*
サブルーチンの計算量について確認しておく。IsListは一定時間。Appendは一つ目のリストの長さに比例する計算量を持つ。（一つ目のリストの長さをnとすると、T_Append=k4*nとする。）

まず、最悪時の入力Lsは、要素数n、入れ子の深さ最大kという条件の元では、以下のようになると考えられる。
[ ... [ A1 A2 ... An ] ... ]
手続きFlattenの計算量、T_Flatten(size(Ls))を求めたいので、size(Ls)を特徴付けるパラメータとして、
size(Ls) = (n,k)
とする。（ただし、nil = [ ] は、(0,1)とする）
'case'文のそれぞれの場合について、漸化式を立てる。
T_Flatten((0,1)) = k1
T_Flatten((n,1)) = k2 + T_Flatten((n-1,1)) (n > 0 のとき)
T_Flatten((n,k)) = k3 + T_Flatten((n,k-1)) + T_Flatten((0,1)) + k4*n（n > 0, k > 0 のとき）
これより、(k3+k1 ::= k5として)
T_Flatten((n,k))
= (k5 + k4*n) + T_Flatten((n,k-1))
= (k5 + k4*n) + ... + (k5 + k4*n) + T_Flatten((n,1))
= (k-1)*(k5 + k4*n) + k2 + ... + k2 + k1
= (k-1)*(k5 + k4*n) + n*k2 + k1
となり、T_Flatten((n,k))は、O(n*k).

注1：本の計算量の定義では、'case'文に対しては全てのケースの最大を取れってなっているけれども、ありえないケースを採用するのはおかしい。「完全にランダム」な場合、最悪のケースを取るのは理解できるが、そうでない場合は、個別に漸化式を立てるのが適切だと思う。
*/

/* 最悪ケースその2
サブルーチンの計算量について確認しておく。IsListは一定時間。Appendは一つ目のリストの長さに比例する計算量を持つが、以下に述べるように、一つ目のリストの長さは常に1なので、定数時間。

まず、最悪時の入力Lsは、要素数n、入れ子の深さ最大kのとき、以下のようになると考えられる。
[ [...[A1]...] [...[A2]...] ... [...[An]...] ]
ここで、[...[At]...]はk-1個の入れ子である。これを入力として考える。
手続きFlattenの計算量、T_Flatten(size(Ls))を求めたいので、size(Ls)を特徴付けるパラメータとして、
size(Ls) = (n,k)
とする。（ただし、n=0のとき、kの値に関わらずnilを表すとする）
'case'文のそれぞれの場合について、漸化式を建てる。
T_Flatten((0,k)) = k1 （n = 0, k:任意 のとき）
T_Flatten((n,k)) = k2 + T_Flatten((1,k-1)) + T_Flatten((n-1,k))（n > 0, k > 0 のとき）
T_Flatten((1,0)) = k3 + T_Flatten（（0,0）） （n = 1, k = 0 のとき）
これを解いて、やはりO(n*k).
*/

declare
fun {Flatten Xs}
   proc {FlattenD Xs ?Ds}
      case Xs
      of nil then Y in Ds=Y#Y
      [] X|Xr andthen {IsList X} then Y1 Y2 Y3 Y4 in
	 {FlattenD X Y1#Y2}
	 {FlattenD Xr Y3#Y4}
	 Y2=Y3
	 Ds=Y1#Y4
      [] X|Xr then Y1 Y2 in
	 {FlattenD Xr Y1#Y2}
	 Ds=(X|Y1)#Y2
      end
   end
   Ys
in
   {FlattenD Xs Ys#nil}
   Ys
end

/*
詳細は略。
連結が一定時間というところだけが違うはずなので、上記最悪ケース1の場合は、O(n)で、ケース2の場合はO(k*n)になるはず。
従って、平均時間はともかく、最悪時間は変わらないと思われる。
*/
