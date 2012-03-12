% 7.高階プログラミングを使うプログラムされたトリガ

% 最初の文が誤訳
%  誤：プログラムされたトリガを実装するには、並列性とデータフロー変数の代わりに高階プログラミングを使う。
%  正：プログラムされたトリガは、並列性とデータフロー変数の代わりに、高階プログラミングを使うことによっても実装できる。

% データフロー変数と並行性を使った実装
proc {DGenerate N ?Xs}
   case Xs
   of X|Xr then
      X=N
      {DGenerate N+1 Xr}
   end
end

proc {DSum Xs ?A Limit}
   if Limit>0 then
      X|Xr=Xs
   in
      {Dsum Xr A+X Limit-1}
   else
      A
   end
end

local Xs S in
   thread {DGenerate 0 Xs} end
   thread S={DSum Xs 0 1000} end
   {Browse S}
end

% 高階プログラミングを使った実装
declare
proc {DGenerate N ?Xs}
   NewXs
   fun{F2}
      {DGenerate N+1 NewXs}
      NewXs
   end
in
   Xs=N#F2
end

fun {DSum Xs ?A Limit}
   if Limit>0 then
      X#F2={Xs}
   in
      {DSum F2 A+X Limit-1}
   else
      A
   end
end

local Xs S in
   {DGenerate 0 Xs}
   S={DSum Xs.2 0 3}
   {Browse S}
end

% #メモ
% コルーチンを実装したということ。
% アキュムレータを消費者に見せないために、関数を入れ子にして、その側の関数を再帰的に呼び出している。
% 言い換えると、DSum内において、Fは外部環境として状態Nを保持しており、状態を更新するために新たに外部環境を再帰的に生成して、その後自身と結果のタプルを返している。無理がある。
