% 10.あるものがリストであるかどうかチェックすること

fun {Leaf X} X\=(_|_) end
% これは以下のように書き換えられる。
fun {Leaf X} if X==(_|_) then false else true end end

% blockするため、まずい。case文は構造が同等であればよいが、内包チェックにおいては未定義値との比較はブロックの要因になる。