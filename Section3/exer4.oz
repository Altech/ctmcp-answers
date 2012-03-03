% 4.反復的階乗計算

/*
.---------- N -----------.
e1 e2 ... ei e(i+1) ... en
             '----i-1----'

現在の計算結果:A
残りの計算:i-1〜1
つまり、中間状態は(A,i)で表せる。
さらに、初期状態は、(1,N)である。
ある状態(1,N)の次の状態は(A*i,i-1)である。
ここから、次の関数が得られる。
*/

fun {Fact N}
   fun {FactIter N A}
      if N==1 then A
      else {Fact N-1 N*A} end
   end
in
   {FactIter N 1}
end
