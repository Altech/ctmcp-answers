%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Mozart System Supplements

% This file gives the extensions to the basic Mozart system that
% are used in the book "Concepts, Techniques, and Models of Computer
% Programming".  The contents of this file can be put in the .ozrc
% file in your home directory, which will cause it to be loaded
% automatically when Mozart starts up.

% Authors: Peter Van Roy and Seif Haridi
% May 9, 2003

declare

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The memory store as used in the exercises
fun {NewStore}
   D={NewDictionary}
   C={NewCell 0}
   proc {Put K X}
      if {Not {Dictionary.member D K}} then
         C:=@C+1
      end
      D.K:=X
   end
   fun {Get K} D.K end
   fun {Size} @C end
in
   storeobject(put:Put get:Get size:Size)
end
proc {Put S K X} {S.put K X} end
fun {Get S K} {S.get K} end
fun {Size S} {S.size} end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Failed values

% This operation creates a failed value, which encapsulates any
% partial value inside an exception.  Any attempt to use the failed
% value will raise the encapsulated partial value as an exception.
fun {FailedValue X}
   {Value.byNeedFail X}
end

% This operation tests if X is a failed value at the instant
% of the test (an unbound variable will return false).
fun {IsFailed X}
   {Value.isFailed X}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nondeterministic choice (WaitTwo)

% This is the WaitTwo operation, which is needed by the
% nondeterministic concurrent model.  The function call
% {WaitTwo X Y} waits until at least one of X and Y is determined.
% It can return 1 if X is determined and 2 if Y is determined.
% (If both are determined, it can return either 1 or 2.)

fun {WaitTwo X Y}
   {Record.waitOr X#Y}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Active object

% This is the NewActive abstraction, which defines active objects.
% It is called in the same way as New, with a class and an initial
% method, and returns an active object.

fun {NewActive Class Init}
   Obj={New Class Init}
   P
in
   thread S in
      {NewPort S P}
      {ForAll S proc {$ M} {Obj M} end}
   end
   proc {$ M} {Send P M} end
end

% 2. Port with close operation

% This is the NewPortClose abstraction, which defines a port that
% has a close operation.  To avoid confusion with the Mozart standard
% port, this ADT is bundled, i.e., the port is hidden inside the Send
% operation.

proc {NewPortClose ?S ?Send ?Close}
   PC={NewCell S}
in
   proc {Send M}
      S in
      {Exchange PC M|S S}
   end
   proc {Close}
      nil=@PC
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lazy problem solving (Solve)

% This is the Solve operation, which returns a lazy list of solutions
% to a relational program.  The list is ordered according to a
% depth-first traversal.  Solve is written using the computation space
% operations of the Space module.

fun {Solve Script}
   {SolStep {Space.new Script} nil}
end

fun {SolStep S Rest}
   case {Space.ask S}
   of failed then Rest
   [] succeeded then {Space.merge S}|Rest
   [] alternatives(N) then 
      {SolLoop S 1 N Rest}
   end
end

fun lazy {SolLoop S I N Rest}
   if I>N then Rest
   elseif I==N then
      {Space.commit S I}
      {SolStep S Rest}
   else Right C in
      Right={SolLoop S I+1 N Rest}
      C={Space.clone S}
      {Space.commit C I}
      {SolStep C Right}
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% Chapter 13 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wait without by-need propagation (WaitQuiet)

% This procedure behaves identically to Wait, except that by-need
% triggers on X are not activated. 

proc {WaitQuiet X}
   {Value.waitQuiet X}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%