% 6.高階プログラミング
% (a)
declare Add Subtract Multiply Mull
fun {Add X Y}
   X+Y
end
fun {Subtract X Y}
   X-Y
end
fun {Multiply X Y}
   X*Y
end
fun {Mull X Y}
   (X+1)*(Y+1)
end

declare GenericPascalList
fun {GenericPascalList Op N}
   if N==1 then [1]
   else {GenericPascal Op N}|{GenericPascalList Op N-1} end
end

{Browse {GenericPascalList Add 7}}
{Browse {GenericPascalList Subtract 7}} % 交互にマイナスが付いた
{Browse {GenericPascalList Multiply 7}} % 二行目以降は全て0
{Browse {GenericPascalList Mull 7}} % 中心ほど増え方が大きい

{Browse {GenericPascal Mull 10}}

% (b)ル―プ命令の導入
for I in
   1..10 do {Browse {GenericPascal Add I}}
end
% 教訓：ル―プは再帰で代用可
