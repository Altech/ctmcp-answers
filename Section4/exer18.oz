% 18.並行性と例外

declare
proc {TryFinally S1 S2}
   B Y
in
   try {S1} B=false catch X then B=true Y=X end
   {S2}
   if B then raise Y end end
end

local U=1 V=2 in
   {TryFinally
    proc{$}
       thread 
	  {TryFinally proc{$} U=V end proc{$} {Browse bing} end}
       end
    end
    proc{$} {Browse bong}  end
   }
end

% 単一化失敗のエラーが報告されただけ。そもそも単一化を例外として補足できてない？？

% ※そもそも並行性の中で例外が発生したときの挙動が本に書いてない気がする…。
% そのスレッドのスタック全部ポップして空になったらトップレベルに例外が報告されてシステム停止、という理解だろうか。だとしたらbingするだけ。
