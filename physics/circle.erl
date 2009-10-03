-module  (circle).
-include ("records.hrl").
-export  ([new/2,overlap/2]).

new(Center = #point{}, Radius) ->
  #circle{center = Center, radius = Radius}.
  
overlap(C1 = #circle{}, C2 = #circle{}) ->
  math:pow((C2#circle.center)#point.x - (C1#circle.center)#point.x, 2) +
  math:pow((C2#circle.center)#point.y - (C1#circle.center)#point.y, 2) =<
  math:pow(C1#circle.radius + C1#circle.radius, 2).