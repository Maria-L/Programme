$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

require_relative'../Extensions/ext_pr1_v4'
require_relative'../Extensions/ext_classes_v1'
require_relative'praedicats'
require_relative'range1d'
require_relative'range2d'
require_relative'union1d'
require_relative'union2d'
require_relative'point2d'

puts Range1d[5,6]
puts Range2d[Range1d[1,5],Range1d[1,3]]
puts Union2d[Union2d[Range2d[Range1d[3,4], Range1d[6,7]], Range2d[Range1d[8,9],Range1d[12,13]]], Range2d[Range1d[14,15], Range1d[18,19]]]