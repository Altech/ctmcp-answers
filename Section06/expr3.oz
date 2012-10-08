% 並行性によって状態をエミュレートする

declare
fun {MakeState Init}
   proc {Loop S V}
      case S of access(X)|S2 then
	 X=V
	 {Loop S2 V}
      [] assign(X)|S2 then
	 {Loop S2 X}
      else skip
      end
   end
   S
in
   thread {Loop S Init} end
   S
end

% ストリームコンテナによるSumList
declare
fun {SumList Xs S}
   Cs = {MakeState S}
   fun {Iter Xs Cs}
      case Xs
      of nil then C|Cr=Cs Y in
	 C=access(Y)
	 Y
      [] X|Xr then C1|C2|Cr=Cs Y  in
	 C1=access(Y)
	 C2=assign(X+Y)
	 {Iter Xr Cr}
      end
   end
in
   {Iter Xs Cs}
end

{Browse {SumList [1 2 3] 0}}

% SumListのように、呼び出しの間で保持すべき状態がない場合、内部的にアキュムレータを追加してやれば、見た目を変更せずにストリームコンテナを使うことができる。
% SumCountを追加しようとしても、関数呼び出しの間にアキュムレータがないため、関数定義時点でのストリームコンテナにしかアクセスできない。従って、見た目を変更せずにSumCountを追加することはできない。
