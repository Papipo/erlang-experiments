-module (molder).
-export ([start/3, start_proc/3,stop/1]).

start(Kind, RawMaterials, Seconds) ->
  spawn_link(?MODULE, start_proc, [Kind, RawMaterials, Seconds * 1000]).
  
start_proc(Kind, RawMaterials, Time) ->
  register(Kind, self()),
  io:format("Starting ~p molder~n", [Kind]),
  clock:start(self(), Time, {mold}),
  mold(Kind, RawMaterials).

mold(Kind, RawMaterials) ->
  receive
    {stop} -> ok;
    {mold} ->
      case take(RawMaterials) of
        true ->
          io:format("~p molded~n", [Kind]),
          mold(Kind, RawMaterials);
        false ->
          io:format("Not enough raw materials to mold ~p~n", [Kind]),
          mold(Kind, RawMaterials)
      end
  end.

take({Material, Amount}) ->
  storage:get(Material, Amount).
  
stop(Kind) ->
  Kind ! {stop}.