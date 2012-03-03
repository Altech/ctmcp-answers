% 2.立方根
declare
fun {Cbrt X}
   fun {CbrtIter Guess}
      if {GoodEnough Guess} then Guess
      else {CbrtIter {Improve Guess}} end
   end
   fun {GoodEnough Guess}
      {Abs X-Guess*Guess*Guess}/X < 0.000001
   end
   fun {Improve Guess}
      (X/(Guess*Guess) + 2.0*Guess)/3.0
   end
   Guess = 1.0
in
   {CbrtIter Guess}
end

{Browse {Cbrt 3.0}}
