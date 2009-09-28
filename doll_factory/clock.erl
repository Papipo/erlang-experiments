-module (clock).
-export ([start/3,clock/3]).

start(Pid, Time, Message) ->
  spawn_link(?MODULE, clock, [Pid, Time, Message]).

clock(Pid, Time, Message) ->
  receive
    after Time ->
      Pid ! Message,
      clock(Pid, Time, Message)
  end.