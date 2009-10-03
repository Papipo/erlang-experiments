-module (test).
-include_lib("eunit/include/eunit.hrl").

point_sum_test_() -> [
  ?_assertEqual(point:new(6,5), point:sum(point:new(2,-3), point:new(4,8)))].
  
point_slope_test_() -> [
  ?_assertEqual(2.0, point:slope(point:new(50,200), point:new(150,400)))].
  
line_slope_test_() -> [
  ?_assertEqual(-2.0, line:slope(line:new(2, 1, 5))),
  ?_assertEqual(0.0, line:slope(line:new(0, 2, 5)))].

line_from_points_test() ->
  Line = line:new(point:new(50,200), point:new(150,400)),
  ?assertEqual(2.0, line:slope(Line)),
  ?assertEqual(108.0, line:y_value(Line, 4)).

line_intersect_test_() -> [
  ?_assertEqual(point:new(3.0,-1.0), line:intersect(line:new(2,3,3), line:new(-1,3,-6))),
  ?_assertEqual(overlap, line:intersect(line:new(-3,6,6), line:new(-1,2,2))),
  ?_assertNot(line:intersect(line:new(-1,2,2), line:new(-1,2,-2)))].