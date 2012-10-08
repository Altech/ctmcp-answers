% 11.遅延性と並列性

declare
fun lazy {MakeX} {Browse x} {Delay 3000} 1 end
fun lazy {MakeY} {Browse y} {Delay 6000} 2 end
fun lazy {MakeZ} {Browse z} {Delay 9000} 3 end
X={MakeX}
Y={MakeY}
Z={MakeZ}
{Browse thread X+Y end +Z}

% MakeXとMakeYが直ちに必要とされるため、それらのDelayが始まり、X+Yの計算が終わる6秒後に、Zが必要とされるため6+9=15秒後に結果が出る。
% 二番目の例は、糖衣構文を解き解すと、Zがスレッド生成直後に必要とされることがわかる。

% 最速で計算するには Thread ... Thread Thread i_1 + i_2 end + i_3 end ... + i_n end とすればよい（スレッド生成にかかる時間が一秒未満であるという前提）。よって次のようにプログラムできる。

{FoldL Ls fun{$ X Y} thread X+Y end end 0}