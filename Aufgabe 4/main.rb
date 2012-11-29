require_relative'../Extensions/ext_pr1_v4'
require_relative'classes'
require_relative'praedicats'
require_relative'translate'
require_relative'bounds'
require_relative'graph_equal'
require_relative'in'

#p bounding_union2d(Union2d[Union2d[Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]],Range2d[Range1d[9,10], Range1d[11,12]]])
#
#p graph_equal_trans?(Union2d[Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]], Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[7,8], Range1d[9,10]]])
#
#p in?(Point2d[2,3],Union2d[Range2d[Range1d[2,2],Range1d[25,4]],Range2d[Range1d[5,6], Range1d[12,13]]])
#
#p in?(Point2d[2,2], Union2d[Range2d[Range1d[0,4], Range1d[0,4]], Union2d[Range2d[Range1d[10,11], Range1d[10,11]],Range2d[Range1d[10,11],Range1d[10,11]]]])
#
#p bounds(Union2d[Union2d[Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]],Range2d[Range1d[9,10], Range1d[11,12]]])