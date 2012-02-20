
% 7.明示的状態

local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
end

local X in
   X={NewCell 23}
   X:=44
   {Browse @X}
end

% 変数の方は23が表示／メモリセルの方は44が表示される
% 変数の方について：23のXと44のXは別々のところに格納されている（格納域変数）。識別子としては、最後に宣言されたものが機能する。
