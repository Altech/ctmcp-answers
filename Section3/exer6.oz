% 6.状態不変表明


fun {Reverse Xs}
   fun {IterReverse Xs Ys}
      case Xs
      of nil then Ys
      [] X|Xr then {IterReverse Xr X|Ys}
      end
   end
in
   {IterReverse Xs nil}
end

% 中間状態：（残りのリスト、すでに逆転されたリスト）= (Ys,Zs) なので、
% P((Ys,Zs)) ::= ( Xs = Append(Reverse(Zs),Ys) )

% 証明
% ■最初にP(初期状態）を証明する。これは、初期状態=（Xs,nil）から、右辺＝Append(nil,Xs)であり、これはXsに等しい。
% ■P（S_(i))（最終状態ではない）が真だと仮定する。このとき、Xs = Append(Reverse(Zs),Ys)である。S_(i+1)は'case'文からZ|Zr=Zsとすると、(Zr,Z|Ys)で、{Append Reverse(Zr) Z|Ys}={Append Reverse(Zs) Ys}は明らかなので、仮定より、P(S_(i+1))=(Xs=Append(Reverse(Zr),Z|Ys))は真。（Reverse(Zs)から、Reverse(Zr）の導出は省略した）
% ※S_(final)（最終状態）=(nil,Zs)で、'case'文より、この関数はZsを返す。Xs=Append(Reverse(Zs),nil)すなわちXs=Reverse(Zs)なので、この結果は正しいことがわかる。（ここから考えると、Reverse(Xs)=Append(Zs,Reverse(Ys))の方が適切な表明だった）
