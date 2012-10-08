% 9.記憶域

% Load file.
% The memory store as used in the exercises
declare
fun {NewStore}
   D={NewDictionary}
   C={NewCell 0}
   proc {Put K X}
      if {Not {Dictionary.member D K}} then
         C:=@C+1
      end
      D.K:=X
   end
   fun {Get K} D.K end
   fun {Size} @C end
in
   storeobject(put:Put get:Get size:Size)
end
proc {Put S K X} {S.put K X} end
fun {Get S K} {S.get K} end
fun {Size S} {S.size} end



% (a)
% NewDectionaryなるクラスから、記憶域は作られている。メモリセルがたくさん集まっている。

declare
S={NewStore}
{Put S 3 [5 2 55]}
{Browse {Get S 3}}

% (b)
declare
local S={NewStore} in
   {Put S 1 [1]}
   fun {FasterPascal N}
      if N > {Size S} then L in
	 L={FasterPascal N-1}
	 {Put S N {AddList {ShiftLeft L} {ShiftRight L}}}
	 {Get S N}
      else {Get S N} end
   end
end

{Browse {FasterPascal 3501}}


% (c)(d)
% 記憶域の内部実装を示せ、という解釈。
declare
fun {NewMemory}
   M = {NewCell nil}
   C = {NewCell 0}
   fun {Find K}
      fun {Iter Ls}
	 case Ls
	 of nil then nil 
	 [] L|Lr then if L.1 == K then L.2
		      else {Iter Lr} end
	 end
      end
   in
      {Iter @M}
   end
   fun {IsExist K}
      {Not ({Find K} == nil)}
   end
   fun {Get K}
      @{Find K}
   end
   proc {Store K V}
      if {Not {IsExist K}} then
	 {Alloc K}
	 C:=@C+1
      end
      {Find K} := V
   end
   proc {Alloc K}
      fun {Iter Ls K}
	 case Ls
	 of nil then (K|{NewCell 0})|nil
	 [] L|Lr then Key = L.1 in
	    if Key < K then L|{Iter Lr K}
	    else (K|{NewCell 0})|Ls end
	 end
      end
   in
      M := {Iter @M K}
   end
   fun {Size}
      @C
   end
in
   message(is_exist:IsExist get:Get store:Store size:Size)
end


declare
M = {NewMemory}

{M.is_exist 1} % => false
{M.store 1 test} 
{M.is_exist 1} % => true
{M.get 1} % => test
{M.store 1 tests} 
{M.get 1} % => tests
{M.store 2 second} 
{M.get 2} % => second
{M.size} % => 2