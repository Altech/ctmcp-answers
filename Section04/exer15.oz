% 15.遅延性の性能

% フィボナッチ関数を評価することにする。

declare
fun {EAdd X Y} X+Y end
fun lazy {LAdd X Y} X+Y end
fun {ESub X Y} X-Y end
fun lazy {LSub X Y} X-Y end
fun {ELeQ X Y} X=<Y end
fun lazy {LLeQ X Y} X=<Y end

declare
fun {EagerFib X}
   if {ELeQ X 2} then 1
   else {EAdd {EagerFib {ESub X 1}} {EagerFib {ESub X 2}}} end
end
fun {LazyFib X}
   if {LLeQ X 2} then 1
   else {LAdd {LazyFib {LSub X 1}} {LazyFib {LSub X 2}}} end
end


fun {ElapsedTime P Size}
   Start={Time.time} Fin Result
in
   Result = {P Size}
   Fin = {Time.time}
   Fin-Start
end



{Browse {ElapsedTime EagerFib 35}} % => 4
{Browse {ElapsedTime LazyFib 35}} % => メモリ足りなくて死んだ(4G超えた)。

{Browse {ElapsedTime EagerFib 33}} % => 1~2
{Browse {ElapsedTime LazyFib 33}} % => 39

% わら。

