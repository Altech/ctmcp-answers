% 4.if文とcase文
% (a)case文によるif文の定義
% if文：if <x> then <s>1 else <s>2

if X then <s>1 else <s>2 end ::=

case X
of true then
   <s>1
[] else
   <s>2
end

/* 言語抽象として考えるなら、さらに例外処理の節を'else'節として追加すると正確。*/
   

% (b)if文によるcase文の定義

case <x> of <label>(<feat>1:<x>1 ... <feat>n:<x>n) then <s>1 else <s>2 end ::=

if {Label <x>}==<label> then
   if {Arity <x>}==[<feat>1 ... <feat>n] then
      local <x>1=<x>.<feat>1 ... <x>n=<x>.<feat>n in
	 <s>1
      end
   else <s>2 end
else <s>2 end

% ※動作未確認