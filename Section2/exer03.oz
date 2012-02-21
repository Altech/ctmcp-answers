% 3.関数と手続き
/* 構文より、関数の末尾は式で終わる必要がある。この場合、'if-then-else'が式である。式としての'if-then-else'において'else'節を記述しなくてもパーサはエラーを吐かない。'else'は定義域でない（ので実行されない）という解釈をしている（と思われる）。すなわち、else節は想定されていないため、そのようなことが起こった場合は例外が発生するのが正しい。*/

declare
fun {Test X}
   if X then 1 end
end

try
   {Browse {Test false}}
catch X then
   {Browse X}
end


% 以下でも同じ考え方でコンパイラはコードを通し、実行において例外が発生する。
declare Y
Y = if false then 1 end
% これは通る。
Y = if true then 1 end


% なお、手続きで書くと以下。明らかに例外は発生しないことがわかる。
declare
proc {Test X ?Y}
   if X then Y = X end
end