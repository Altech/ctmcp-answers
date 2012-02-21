% 9.末尾再帰
fun {Sum1 N}
   if N==0 then 0 else N+{Sum1 N-1} end
end
fun {Sum2 N S}
   if N==0 then S else {Sum2 N-1 N+S} end
end

% (a) 核言語への展開
% ※'else'節だけ展開する。
declare 
fun {Sum1 N}
   if N == 0 then 0
   else Mid in
      Mid = {Sum1 N-1}
      N + Mid
   end
end
fun {Sum2 N S}
   if N == 0 then S
   else Mid1 Mid2 in
      Mid1 = N-1
      Mid2 = N+S
      {Sum2 Mid1 Mid2}
   end
end
{Browse {Sum1 10}}

% (b)
Sum1 = proc {$ N ?S}
	  if N == 0 then S = 0
	  else Mid NMid in
	     NMid = N-1
	     {Sum NMid Mid}
	     S = N + Mid
	  end
       end
% N = 0 のとき：( [ ({Sum1 NMid Mid},{N=>n1,NMid=>n0,S=>m1,Mid=>m0}),(S=N+Mid,{N=>n1,NMid=>n0,S=>m1,Mid=>m0}),...,(S=N+Mid,{N=>n10,NMid=>n9,S=>res,Mid=>m9}) ], {res,m9,...,m0,n10=10,...,n0=0} )
% のように、意味スタック、格納域ともにNに比例する。

Sum2 = proc {$ N S ?Sn}
	  if N == 0 then Sn = S
	  else NMid SMid in
	     NMid = N-1
	     SMid = N+S
	     {Sum2 NMid SMid Sn}
	  end
       end
% N = 0 のとき：( [ ({Sum2 NMid Mid Sn},{Sn=>res,N=>n1,NMid=>n0,S=>s1,SMid=>s2}) ], {res,n10=10,...,n0=0,s10=10,...,s0=55} )
% (GCによる格納域の最適化）=> {res,n1=1,n0=0,s1=54,s0=55}
% のように、意味スタックは常に一定数以下。格納域も、到達可能な変数は常に一定数以下。


% (c)
{Browse {Sum1 100000000}} % => 20秒ほど
{Browse {Sum2 100000000 0}} % => 4分以上（不明） スタックがオーバーフローする？