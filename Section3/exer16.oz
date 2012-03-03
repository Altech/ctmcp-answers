% 16.末尾再帰の畳み込み
declare
fun {Convolute Xs Ys}
   proc {ConvoluteIter Xs Ys ?Zs}
      case Xs
      of nil then Zs = nil
      [] X|Xr then
	 case Ys of Y|Yr then Rs in
	    Zs = X#Y|Rs
	    {ConvoluteIter Xr Yr Rs}
	 end
      end
   end
in
   {ConvoluteIter Xs {Reverse Ys}}
end

{Browse {Convolute [2 4 6] [1 3 5]}}
