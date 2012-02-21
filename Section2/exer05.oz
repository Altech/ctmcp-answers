% 5.case文
declare Test
proc {Test X}
   case X
   of a|Z then {Browse 'case'(1)}
   [] f(a) then {Browse 'case'(2)}
   [] Y|Z andthen Y==Z then {Browse 'case'(3)}
   [] Y|Z then {Browse 'case'(4)}
   [] f(Y) then {Browse 'case'(5)}
   else {Browse 'case'(6)} end
end
 
{Test [b c a]} % => 4
{Test f(b(3))} % => 5
{Test f(a)}    % => 2
{Test f(a(3))} % => 5
{Test f(d)}    % => 5
{Test [a b c]} % => 1
{Test [c a b]} % => 4
{Test a|a}     % => 1
{Test '|'(a b c)} % => 6

% 核言語に翻訳すると以下のようになる。
declare Test
proc {Test X}
   case X of '|'(a Z) then {Browse 'case'(1)}
   else
      case X of f(a) then {Browse 'case'(2)}
      else
	 case X of '|'(Y Z) then
	    if Y==Z then {Browse 'case'(3)}
	    else % andthenはelseで以降を二重に記述しなければならない
	       case X of '|'(Y Z) then {Browse 'case'(4)}
	       else
		  case X of f(Y) then {Browse 'case'(5)}
		  else
		     {Browse 'case'(6)}
		  end
	       end
	    end
	 else
	    case X of '|'(Y Z) then {Browse 'case'(4)}
	    else
	       case X of f(Y) then {Browse 'case'(5)}
	       else
		  {Browse 'case'(6)}
	       end
	    end
	 end
      end
   end
end