-module (doll_factory).
-export ([start/0]).

start() ->
  storage:start(plastic, 1000),
  molder:start(arms,  {plastic, 0.2}, 6),
  molder:start(legs,  {plastic, 0.2}, 5),
  molder:start(head,  {plastic, 0.1}, 4),
  molder:start(torso, {plastic, 0.5}, 10).