-module (storage).
-export ([start/2,start_proc/2, get/2,add/2,remaining/1,stop/1]).

start(Kind, Stock) ->
  spawn_link(?MODULE, start_proc, [Kind, Stock]).

start_proc(Kind, Stock) ->
  register(Kind, self()),
  io:format("Starting ~p storage~n", [Kind]),
  store(Kind, Stock).

store(Kind, Stock) ->
  receive
    {add, Amount} ->
      io:format("Storage received ~p units of ~p!~n", [Amount, Kind]),
      store(Kind, Stock + Amount);
    {get, Amount, Pid} ->
      case Amount =< Stock of
        true ->
          Pid ! ok,
          io:format("~p took ~p ~p~n", [Pid, Amount, Kind]),
          store(Kind, Stock - Amount);
        false ->
          Pid ! error,
          io:format("~p wanted to take ~p ~p. Only ~p remains~n", [Pid, Amount, Kind, Stock]),
          store(Kind, Stock)
      end;
    {remaining, Pid} ->
      Pid ! Stock,
      store(Kind, Stock);
    {stop} ->
      ok
  end.

get(Kind, Amount) ->
  Kind ! {get, Amount, self()},
  receive
    ok -> true;
    error -> false
  end.

add(Kind, Amount) ->
  Kind ! {add, Amount},
  ok.

remaining(Kind) ->
  Kind ! {remaining, self()},
  receive
    Amount -> Amount
  end.

stop(Kind) ->
  Kind ! {stop}.