% 14.FIFOキュー
declare
fun {NewQueue} X in q(0 X X) end
fun {Insert Q X}
   case Q of q(N S E) then E1 in
      E=X|E1
      q(N+1 S E1)
   end
end
fun {Delete Q X}
   case Q of q(N S E) then
      q(N-1 S.2 E)
   end
end
fun {IsEmpty Q} case Q of q(N S E) then N==0 end end

% (a)
/*
差分リストとしては、X#XからX#(X1|X)のようになる。ここで、X1は未束縛。
空の差分リストにこのような操作を加えると、次の挿入操作は、以下のようになる。末尾に対して、挿入したい値X2と未束縛変数Eを使ってX1|X=X2|Eと単一化。
この結果、Eには、X1|Xではなく、Xが束縛される。X1がキャンセラーの役目を果たし、挿入と同時に削除されたかのように振舞う。
*/

% (b)
% 空でないとき、例えば(X1|E)#Eにおいて、X1|E==Eはfalseになって欲しいが、等しくなる可能性があるため、ブロックしてしまう。
