-module  (line).
-include ("records.hrl").
-export  ([new/2, new/3, slope/1, slope_intercept/2]).

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

slope_intercept(Line = #line{}, X) -> (Line#line.function)(X).
