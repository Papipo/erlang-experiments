-module (assembler).
-export ([start/3, start_proc/3,stop/1]).

start(Kind, RawMaterials, Seconds) ->
  spawn_link(?MODULE, start_proc, [Kind, RawMaterials, Seconds * 1000]).
  
start_proc(Kind, RawMaterials, Time) ->
  register(atom_to_name(Kind), self()),
  io:format("Starting ~p assembler~n", [Kind]),
  clock:start(self(), Time, {assemble}),
  assemble(Kind, RawMaterials).

assemble(Kind, RawMaterials) ->
  receive
    {stop} -> ok;
    {assemble} ->
      case take(RawMaterials) of
        true ->
          io:format("~p assembled~n", [Kind]),
          storage:add(Kind, 1),
          assemble(Kind, RawMaterials);
        false ->
          io:format("Not enough raw materials to assemble ~p~n", [Kind]),
          assemble(Kind, RawMaterials)
      end
  end.

take({Material, Amount}) ->
  storage:get(Material, Amount);
take([]) ->
  true;
take([H|T]) ->
  take(H),
  take(T).
  
stop(Kind) ->
  atom_to_name(Kind) ! {stop}.

atom_to_name(Atom) ->
  list_to_atom(atom_to_list(Atom) ++ "_assembler").