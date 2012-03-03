% 5.反復的SumList

/*
初期状態：(0,Xs)
中間状態：（現在の結果,残りのリスト）= (A,Ys)
次の状態との関係：(A,Ys) => (A+Y,Yr)
*/

declare
fun {SumList Xs}
   fun {SumListIter Ys A}
      case Ys
      of nil then A
      [] Y|Yr then {SumListIter Yr A+Y} end
   end
in
   {SumListIter Xs 0}
end
