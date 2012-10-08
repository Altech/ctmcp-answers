% セルを使う状態

declare
fun {SumList Xs S}
   case Xs
   of nil then S
   [] X|Xr then {SumList Xs X+S}
   end
end

declare
fun {SumList Xs S}
   C = {NewCell S}
   fun {Iter Xs}
      case Xs
      of nil then @C
      [] X|Xr then
	 C := @C + X
	 {Iter Xr}
      end
   end
in
   {Iter Xs}
end


{Browse {SumList [1 2 3] 0}}