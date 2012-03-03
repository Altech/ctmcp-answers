% 13.行列操作
declare AddMat SubMat MulMat TransMat

local
   fun {FMat X Y F}
      case X of X1|X1r then
	 case Y of Y1|Y1r then
	    {FList X1 Y1 F}|{FMat X1r Y1r F}
	 end
      [] nil then nil end
   end
   fun {FList Xs Ys F}
      case Xs of X|Xr then
	 case Ys of Y|Yr then
	    {F X Y}|{FList Xr Yr F}
	 end
      [] nil then nil end
   end
in
   fun {AddMat X Y}
      {FMat X Y fun{$ X Y} X+Y end}
   end
   fun {SubMat X Y}
      {FMat X Y fun{$ X Y} X-Y end}
   end
end

fun {TransMat Mat} % 効率微妙？
   fun {TransMatIter Mat ?S}
      case Mat of X|Xr then
	 {TransMatIter Xr {TransLine X S}}
      [] nil then S end
   end
   fun {TransLine Xs S}
      case Xs of X|Xr then
	 case S of Sa|Sr then
	    (X|Sa)|{TransLine Xr Sr} end
      [] nil then nil end
   end
   fun {PreProcess Xs}
      case Xs of _|Xr then nil|{PreProcess Xr} else nil end
   end
   fun {AfterProcess Xs}
      case Xs of X|Xr then {Reverse X}|{AfterProcess Xr} [] nil then nil end
   end
in
   {AfterProcess {TransMatIter Mat {PreProcess Mat.1}}}
end

fun {MulMat X Y}
   fun {MulMatIter AM BM}
      case AM of A|Ar then
	 {MulMatLine A BM}|{MulMatIter Ar BM}
      [] nil then nil end
   end
   fun {MulMatLine A BM}
      case BM of B|Br then
	 {MultSumList A B 0}|{MulMatLine A Br}
      [] nil then nil end
   end
   fun {MultSumList A B ?S}
      case A of X|Xr then
	 case B of Y|Yr then
	    {MultSumList Xr Yr (X*Y)+S} end
      [] nil then S end
   end
   A = X
   B = {TransMat Y}
in
   {MulMatIter A B}
end

declare
X=[[1 2 3] [2 1 2]]
Y=[[3 2 3] [3 1 1]]
Z=[[1 2] [1 1] [1 2]]
U=[[2 1 1] [3 1 0]]
{Browse {AddMat X Y}}
{Browse {TransMat X}}
{Browse {MulMat Z U}}
