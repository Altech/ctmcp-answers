% 8.明示的状態と関数
% 問題点：関数内でメモリセルを宣言、初期化しているので、それぞれの引数は別の格納域に保存される。→カウントは保持されない

declare
local Acc in
   Acc={NewCell 0}
   fun {Accumulate N}
      Acc:=@Acc+N
      @Acc
   end
end

{Browse {Accumulate 5}}
{Browse {Accumulate 10}}
{Browse {Accumulate 34}}
