% 2.文脈的環境
/* このステップが無ければ、呼び出しの度に手続きMulByNの挙動が変わってしまう。実行がその引数のみによって決まるためには、このステップが必要である。*/

% 呼び出し時の環境にNが存在しない例
declare A=10 B

local MulByn in
   local N in
      N=3
      proc {MulByn X ?Y}
	 Y=N*X
      end
   end
   {MulByn A B}
   {Browse B} % =>30
   % {Browse N} => 'variable N not introduced'
end

% 呼び出し時の環境にNが存在するが、3以外の値に束縛されている例
declare A=10 B
local MulByn in
   local N in
      N=3
      proc {MulByn X ?Y}
	 Y=N*X
      end
   end
   local N in
      N=10
      {MulByn A B}
      {Browse B} % =>30
    % {Browse N} => 10
   end
end