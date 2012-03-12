% 17.ハミング問題

% Create Primes
declare
fun lazy {LFilter Xs F}
   case Xs
   of nil then nil
   [] X|Xr then if {F X} then X|{LFilter Xr F} else {LFilter Xr F} end
   end
end
fun lazy {Generate N}
   N|{Generate N+1}
end
fun {Sieve Xs N}
   if N == 0 then nil
   else
      case Xs of X|Xr then Ys in
	 Ys = {LFilter Xr fun {$ Y} Y mod X \= 0 end} 
	 X|{Sieve Ys N-1}
      end
   end
end
fun {GetPrimes N}
   {Sieve {Generate 2} N}
end

% Tools
declare
proc {Touch N H}
   if N>0 then {Touch N-1 H.2} else skip end
end
fun lazy {Times N H}
   case H of X|H2 then N*X|{Times N H2} else nil end
end
fun lazy {Merge Xs Ys}
   case Xs#Ys of (X|Xr)#(Y|Yr) then
      if X<Y then X|{Merge Xr Ys}
      elseif X>Y then Y|{Merge Xs Yr}
      else X|{Merge Xr Yr}
      end
   end
end
fun {MergeN Hs}
   case Hs
   of H1|H2|nil then {Merge H1 H2}
   [] H|Hr then {Merge H {MergeN Hr}}
   end
end

% Main
declare
fun {Hamming N K}
   Primes = {GetPrimes K}
   H = 1|{MergeN {Map Primes fun{$ Prime} {Times Prime H} end}}
in
   {Touch N H}
   H
end

{Browse {Hamming 30 3}}
