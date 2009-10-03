-module  (point).
-include ("records.hrl").
-export  ([new/2, sum/2, slope/2]).

new(X, Y) -> #point{x = X, y = Y}.
  
sum(One = #point{}, Two = #point{}) ->
  new(One#point.x + Two#point.x, One#point.y + Two#point.y).
  
slope(One = #point{}, Two = #point{}) ->
  (Two#point.y - One#point.y) / (Two#point.x - One#point.x).