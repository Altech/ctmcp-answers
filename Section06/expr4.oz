% ポートを実装すること

declare
proc {NewWrapper Wrap Unwrap}
   Key={NewName} in
   fun {Wrap X}
      {Chunk.new w(Key:X)}
   end
   fun {Unwrap W}
      try W.Key catch _ then raise error(unwrap(W)) end end
   end
end
   

declare NewPort Send
local Wrap Unwrap in
   {NewWrapper Wrap Unwrap}
   proc {NewPort Stream Port} S in 
      Port={Wrap {NewCell S}}
      Stream=!!S
   end
   proc {Send Port X} P in
      try 
	 P = {Unwrap Port}
      catch _ then
	 {Browse typerror}
      end
      local Si|Sr=@P in
	 Si = X
	 P := Sr
      end
   end
end

% ポートは抽象的には一意の定数とストリームの末尾の対として保持されているんだけど、実際はポート生成のときに使うNewCell自体が一意の識別子を生成するのでそれが末尾を指すようにしてやればいい。