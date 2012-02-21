% 7.字句的スコ―プ閉包
declare Max3 Max5
proc {SpecialMax Value ?SMax}
   fun {SMax X} 
      if X>Value then X else Value end
   end
end
{SpecialMax 3 Max3} 
{SpecialMax 5 Max5}

% 少し書き直すと以下。
proc {SpecialMax Value ?SMax}
   SMax = fun {$ X} 
	     if X>Value then X else Value end
	  end
end

% 実行は以下。
{Browse [{Max3 4} {Max5 4}]} % => [4 5]

