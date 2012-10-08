% 6.case文再訪

declare
proc {Test X}
   case X of f(a Y c) then {Browse 'case'(1)}
   else {Browse'case'(2)} end
end

declare X Y {Test f(X b Y)} % f(x1 b y1) f(a Y2 c) ?  x1 == a && y1 ==c ?  => block
declare X Y {Test f(a Y d)} % f(a Y1 d)  f(a Y2 c) ?  a  == a && d == c ?  => 'case'(2)
declare X Y {Test f(X Y d)} % f(x1 y1 d) f(a Y2 c) ?  x1 == a && c == d ?  => 'case'(2)ではなくblock

/* 3番目について：内包チェック、反駁チェックの場合、未束縛の変数があったら、とりあえず飛ばして次を調べるが（以下）、'case'文では、最初から調べて、未束縛の変数があれば（次を調べず）ブロックするみたい。 */
declare X Y 
{Browse f(X Y a) == f(c d b)} % => false

/* 考え方として、'case'文で与えられる分解対象は、確定状態であるという想定があって、それに対して両立するかどうかをチェックする、という感じだろうか。*/

declare X Y
if f(X Y d) == f(a Y c) then {Browse 'case'(1)}
else {Browse 'case'(2)} end % => 'case'(2)