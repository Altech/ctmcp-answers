% 10.核言語への展開
fun {SMerge Xs Ys}
   case Xs#Ys
   of nil#Ys then Ys
   [] Xs#nil then Xs
   [] (X|Xr)#(Y|Yr) then
      if X=<Y then X|{SMerge Xr Ys}
      else Y|{SMerge Xs Yr} end
   end
end

SMerge = proc {$ Xs Ys ?S}
	    case Xs of nil then S = Ys
	    else
	       case Ys of nil then S = Xs
	       else
		  case Xs of X|Xr then
		     case Ys of Y|Yr then
			if X=<Y then
			   local Mid in
			      S = X|Mid
			      {SMerge Xr Ys Mid}
			   end
			else
			   local Mid in
			      S = Y|Mid
			      {SMerge Xs Yr Mid}
			   end
			end
		     end
		  end
	       end
	    end
	 end
% データ構造中の呼び出しでは、束縛が先に行われる。