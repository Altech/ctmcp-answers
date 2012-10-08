% 7.別のappend関数
fun {CorrectAppend Ls Ms}
   case Ls
   of nil then Ms
   [] L|Lr then L|{Append Lr Ms}
   end
end

fun {Append Ls Ms}
   case Ms
   of nil then Ls
   [] X|Mr then {Append {Append Ls [X]} Mr}
   end
end

% 内側の再帰呼び出しに注目すると、第二引数がnilになることがないので、終了しない。
