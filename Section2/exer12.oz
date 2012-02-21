% 12.finally節を持つ例外
% 要件は、<s>1を実行後、<s>2を実行することと、例外が発生したのであれば、その例外を確実に外まで伝えること、の2点。従って、以下のようになる

% 値可変変数が使えるのであれば、こんな感じ。
try <s>1 finally <s>2 end ::=

local Boolean = {NewCell false} E in
   try
      <s>1
   catch X then
      E = X
      Boolean := true
   end
   <s>2
   if Boolean then raise E end end
end

% セルつかっちゃったー。束縛されているかを確認するIsBoundが欲しい。

