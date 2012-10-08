% 8.制御抽象
% (a)
<expression>1 andthen <expression>2 ::= if <expression>1 then <expression>2 else false end
% 同じ結果になる。({BP1}がfalseのとき、{BP2}は呼び出されない)

% (b)
<expression>2 orelse <expression>2 ::= if <expression>1 then true else <expression>2 end

fun {OrElse BP1 BP2}
   if {BP1} then true else {BP2} end
end