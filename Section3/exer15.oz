% 15.クイックソート
declare
fun {QuickSort Ls}
   fun {QuickSortIter Ls E}
      case Ls
      of nil then E
      [] L|Lr then Ys Zs in
	 {Devide Lr L Ys Zs}
	 {QuickSortIter Ys L|{QuickSortIter Zs E}}
      end
   end
   proc {Devide Ls P ?Ys ?Zs}
      case Ls
      of nil then Ys=nil Zs=nil
      [] L|Lr then
	 if L < P then Ys = L|{Devide Lr P $ Zs}
	 else Zs = L|{Devide Lr P Ys $} end
      end
   end
in
   {QuickSortIter Ls nil}
end

{Browse {QuickSort [3 2 1 4 5 6 0 1]}}
{Browse {QuickSort [95 64 56 14 1 90 48 11 38 63 66 62 58 26 31 7 6 87 94 18 19 26 60 44 69 45 67 49 57 53 14 50 40 32 91 33 61 14 44 22 16 57 56 69 19 13 88 84 20 22 8 9 69 71 13 45 84 55 91 16 43 2 67 11 13 13 89 64 27 69 84 34 12 61 51 100 51 26 91 97 49 78 40 77 84 73 98 65 49 78 53 22 45 26 35 45 12 56 70 62 57 86 90 1 38 35 63 14 96 16 46 2 85 88 94 64 77 70 22 9 7 20 59 44 48 59 85 12 56 91 36 6 89 93 7 57 7 40 11 72 93 80 99 46 77 10 71 64 73 71 85 10 71 50 4 31 84 23 59 89 12 55 30 12 80 99 37 19 27 83 25 44 21 64 80 36 72 96 91 77 29 82 60 97 15 71 62 75 77 48 63]}}
