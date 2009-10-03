-module  (line).
-include ("records.hrl").
-export  ([new/2, new/3, slope/1, y_value/2, intersect/2]).

new(A, B, C) when is_number(A) and is_number(B) and is_number(C) ->
  Slope = -A / B,
  Function = fun(X) -> (C - A * X) / B end,
  new(Function, Slope).

new(Function, Slope) when is_function(Function) ->
  #line{function = Function, slope = Slope};
new(From = #point{}, To = #point{}) ->
  Slope = point:slope(From, To),
  Function = fun(X) -> Slope * (X - From#point.x) + From#point.y end,
  new(Function, Slope).

slope(Line = #line{}) -> Line#line.slope.

y_value(Line = #line{}, X) -> (Line#line.function)(X).

intersect(One = #line{}, Two = #line{}) ->
  case are_parallel(One, Two) of
    true    -> false;
    overlap -> overlap;
    false   -> intersection_point(One, Two)
  end.

are_parallel(One = #line{}, Two = #line{}) ->
  case line:slope(One) == line:slope(Two) of
    true ->
      case line:y_value(One, 0) == line:y_value(Two, 0) of
        true -> overlap;
        false -> true
      end;
    false -> false
  end.

intersection_point(L1 = #line{}, L2 = #line{}) ->
  P1 = point:new(0, line:y_value(L1, 0)),
  P2 = point:new(0, line:y_value(L2, 0)),
  X = (line:slope(L1) * P1#point.x - line:slope(L2) * P2#point.x + P2#point.y - P1#point.y) / (line:slope(L1) - line:slope(L2)),
  Y = line:y_value(L1, X),
  point:new(X,Y).
