# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'main'

class GraphEqualTest < Test::Unit::TestCase
  def test_graph_equal
    assert_equal(false, graph_equal_?(0,Range1d[0,0]))
    assert_equal(true, graph_equal_?(Range1d[0,0], Range1d[0,0]))
    assert_equal(false, graph_equal_?(Range1d[1,2], Range1d[2,3]))
    assert_equal(true, graph_equal_?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]))
    assert_equal(false, graph_equal_?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,1]]))
    assert_equal(true, graph_equal_?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(false, graph_equal_?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,4]]))
    assert_equal(true, graph_equal_?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    assert_equal(false, graph_equal_?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,18]]]))
    
    assert_raise(RuntimeError){
      graph_equal_?("a", 0)
    }
    assert_raise(RuntimeError){
      graph_equal_?(0,"a")
    }
    

    assert_equal(false, graph_equal?(0,Point2d[1,2]))
    assert_equal(true, graph_equal?(Range1d[0,0], Range1d[0,0]))
    assert_equal(false, graph_equal?(Range1d[1,2], Range1d[2,3]))
    assert_equal(true, graph_equal?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]))
    assert_equal(false, graph_equal?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,1]]))
    assert_equal(true, graph_equal?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(false, graph_equal?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,4]]))
    assert_equal(true, graph_equal?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    assert_equal(false, graph_equal?("a",Range1d[0,0]))
    assert_equal(false, graph_equal?(Range1d[0,0],"a"))
    
    assert_raise(RuntimeError){
      graph_equal?("a",'b')
    }
    

    assert_equal(false, graph_equal_trans?(Range1d[0,0],Range1d[1,2]))
    assert_equal(true, graph_equal_trans?(Range1d[0,0], Range1d[0,0]))
    assert_equal(true, graph_equal_trans?(Range1d[1,2], Range1d[2,3]))
    assert_equal(true, graph_equal_trans?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[1,1], Range1d[1,1]]))
    assert_equal(false, graph_equal_trans?(Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[1,1], Range1d[1,2]]))
    assert_equal(true, graph_equal_trans?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,4]]))
    assert_equal(false, graph_equal_trans?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,5]]))
    assert_equal(true, graph_equal_trans?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,18]]]))
    assert_equal(false, graph_equal_trans?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,19]]]))
    assert_equal(false, graph_equal_trans?("a",Range1d[0,0]))
    assert_equal(false, graph_equal_trans?(Range1d[0,0],"a"))
    
    assert_raise(RuntimeError){
      graph_equal_trans?("a",'b')
    }
    assert_raise(RuntimeError){
      graph_equal_trans?(2,3)
    }
  end
end
