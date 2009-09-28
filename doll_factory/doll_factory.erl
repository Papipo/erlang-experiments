-module (doll_factory).
-export ([start/0,stop/1]).

start() ->
  [
    storage:start(plastic, 1000),
    storage:start(arms, 0),
    storage:start(legs, 0),
    storage:start(head, 0),
    storage:start(torso, 0),
    storage:start(doll, 0),
    assembler:start(arms,  [{plastic, 2}], 6),
    assembler:start(legs,  [{plastic, 2}], 5),
    assembler:start(head,  [{plastic, 1}], 4),
    assembler:start(torso, [{plastic, 5}], 10),
    assembler:start(doll, [{arms, 1}, {legs, 1}, {head, 1}, {torso, 1}], 8)
  ].
  
stop([]) -> ok;
stop([Pid|Tail]) ->
  Pid ! {stop},
  stop(Tail).