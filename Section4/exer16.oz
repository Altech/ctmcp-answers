% 16.by-need実行

% スレッド化すればよい。

proc {Wait X}
   thread if X==unit then skip else skip end end
end
