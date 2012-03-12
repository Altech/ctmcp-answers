% 3.並行フィボナッチ

declare
fun {Fib X}
   if X =< 2 then 1
   else {Fib X-1} + {Fib X-2} end
end

fun {ConcurrentFib X}
   if X =< 2 then 1
   else thread {Fib X-1} end + thread {Fib X-2} end end
end

fun {ElapsedTime P Size}
   Start={Time.time} Fin Result
in
   Result = {P Size}
   Fin = {Time.time}
   Fin-Start
end

{Browse {ElapsedTime Fib 40}} % => 16
{Browse {ElapsedTime ConcurrentFib 45}} % => 16

% Env :
  % Model Name:	MacBook Pro
  % Model Identifier:	MacBookPro8,2
  % Processor Name:	Intel Core i7
  % Processor Speed:	2 GHz
  % Number of Processors:	1
  % Total Number of Cores:	4
  % L2 Cache (per Core):	256 KB
  % L3 Cache:	6 MB
  % Memory:	4 GB

% Size          | 40 | 45 
% Fib           | 16 | 179
% ConcurrentFib | 16 | 183


% スレッド生成数は1万いくらとかそんな感じ。
% Nの関数としては Threads(N) = Threads(N-1) + Threads(N-2) だから、とりあえず指数オーダー。