
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

module Test
  module Unit
    module Assertions
      class AssertionMessage
        class << self
          def ensure_diffable_string(string)
            string = string.dup.force_encoding("ASCII-8BIT") if string.respond_to?(:encoding) and 
              string.encoding.respond_to?(:ascii_compatible?) and
              !string.encoding.ascii_compatible?
            string
          end
        end
      end
    end
  end  
end


require 'test/unit'
require 'clock_main'

class ClockMainTest < Test::Unit::TestCase
  def test_clock_main

    ##### Transformationen #####

    ##### to_clock_sec #####
    
    assert_equal(ClockSec[0],Clock24[0,0,0].to_clock_sec())
    assert_equal(ClockSec[0],Clock12[:AM,0,0,0].to_clock_sec())
    assert_equal(ClockSec[46923],Clock12[:PM,1,2,3].to_clock_sec())
    
    ##### to_clock24 #####
    
    assert_equal(Clock24[0,0,0],ClockSec[0].to_clock24())
    assert_equal(Clock24[0,0,0],Clock12[:AM,0,0,0].to_clock24())
    assert_equal(Clock24[0,0,0],Clock24[0,0,0].to_clock24())
    
    ##### to_clock12 #####
    
    assert_equal(Clock12[:AM,0,0,0],ClockSec[0].to_clock12())
    assert_equal(Clock12[:AM,0,0,0],Clock12[:AM,0,0,0].to_clock12())
    assert_equal(Clock12[:AM,0,0,0],Clock24[0,0,0].to_clock12())

    
    ##### Methoden auf Clocks #####
    
    ##### clock_succ #####
    
    assert_equal(Clock24[0,0,1],Clock24[0,0,0].succ())
    assert_equal(Clock12[:AM,0,0,1],Clock12[:AM,0,0,0].succ())
    assert_equal(ClockSec[1],ClockSec[0].succ())
    
    assert_equal(Clock24[0,0,0],Clock24[23,59,59].succ())
    assert_equal(Clock12[:AM,0,0,0],Clock12[:PM,11,59,59].succ())
    assert_equal(ClockSec[0],ClockSec[86399].succ())
    
    
    ##### clock_pred #####
    
    assert_equal(Clock24[0,0,0],Clock24[0,0,1].pred())
    assert_equal(Clock12[:AM,0,0,0],Clock12[:AM,0,0,1].pred())
    assert_equal(ClockSec[0],ClockSec[1].pred())
    
    assert_equal(Clock24[23,59,59],Clock24[0,0,0].pred())
    assert_equal(Clock12[:PM,11,59,59],Clock12[:AM,0,0,0].pred())
    assert_equal(ClockSec[86399],ClockSec[0].pred())
    
    
    ##### clock_add #####
    
    assert_equal(Clock24[21, 40, 10], Clock24[12,34,2].add(Clock12[:AM,9,6,8]))
    assert_equal(Clock24[13,34,2], Clock24[12,34,2].add(ClockSec[3600]))
    assert_equal(Clock24[8,50,44], Clock24[5,45,22].add(Clock24[3,5,22]))
    assert_equal(ClockSec[36922], ClockSec[3600].add(Clock12[:AM,9,15,22]))
    assert_equal(ClockSec[26625], ClockSec[3600].add(Clock24[6,23,45]))
    assert_equal(ClockSec[4000], ClockSec[3600].add(ClockSec[400]))
    
    assert_raise(RuntimeError) {
      Clock12[:AM,1,2,3].add(100)
    }
    assert_raise(RuntimeError) {
      Clock24[1,2,3].add('a')
    }
    
    ##### clock_sub #####
    
    assert_equal(Clock24[0,0,0], Clock24[0,1,40].sub(Clock12[:AM,0,1,40]))
    assert_equal(Clock24[0,0,0], Clock24[0,1,40].sub(ClockSec[100]))
    assert_equal(Clock24[0,0,0], Clock24[0,1,40].sub(Clock24[0,1,40]))
    assert_equal(ClockSec[0], ClockSec[100].sub(Clock12[:AM,0,1,40]))
    assert_equal(ClockSec[0], ClockSec[100].sub(Clock24[0,1,40]))
    assert_equal(ClockSec[0], ClockSec[100].sub(ClockSec[100]))
    
    assert_raise(RuntimeError) {
      Clock12[:AM,1,2,3].sub(100)
    }
    assert_raise(RuntimeError) {
      Clock12[:AM,1,2,3].sub('a')
    }
    
    ##### clock_equal ####
    
    assert_equal(true,Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,0]))
    assert_equal(true,Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,0]))
    assert_equal(true,Clock12[:AM,0,0,0].clock_equal(ClockSec[0]))
    assert_equal(false,Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,1]))
    assert_equal(false,Clock12[:AM,0,0,0].clock_equal(ClockSec[1]))
    assert_equal(false,Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,1]))
    assert_equal(false,Clock12[:AM,0,0,0].clock_equal('a'))
    assert_equal(true,ClockSec[0].clock_equal(Clock12[:AM,0,0,0]))
    assert_equal(true,ClockSec[0].clock_equal(Clock24[0,0,0]))
    assert_equal(true,ClockSec[0].clock_equal(ClockSec[0]))
    assert_equal(false,ClockSec[0].clock_equal(Clock12[:AM,0,0,1]))
    assert_equal(false,ClockSec[0].clock_equal(ClockSec[1]))
    assert_equal(false,ClockSec[0].clock_equal(Clock24[0,0,1]))
    assert_equal(false,ClockSec[0].clock_equal('a'))
    assert_equal(true,Clock24[0,0,0].clock_equal(Clock12[:AM,0,0,0]))
    assert_equal(true,Clock24[0,0,0].clock_equal(Clock24[0,0,0]))
    assert_equal(true,Clock24[0,0,0].clock_equal(ClockSec[0]))
    assert_equal(false,Clock24[0,0,0].clock_equal(Clock12[:AM,0,0,1]))
    assert_equal(false,Clock24[0,0,0].clock_equal(ClockSec[1]))
    assert_equal(false,Clock24[0,0,0].clock_equal(Clock24[0,0,1]))
    assert_equal(false,Clock24[0,0,0].clock_equal('a'))
    
    
    ##### Get-Methoden #####
    
    ##### hour24 #####
    
    assert_equal(1,Clock24[1,2,3].hour24())
    assert_equal(1,Clock12[:AM,1,2,3].hour24())
    assert_equal(1,ClockSec[3723].hour24())
    
    ##### hour12 #####
    
    assert_equal(1,Clock24[1,2,3].hour12())
    assert_equal(1,Clock12[:AM,1,2,3].hour12())
    assert_equal(1,ClockSec[3723].hour12())

    ##### halve #####
    
    assert_equal(:AM,Clock24[1,2,3].halve())
    assert_equal(:AM,Clock12[:AM,1,2,3].halve())
    assert_equal(:AM,ClockSec[3723].halve())

    ##### min #####
    
    assert_equal(2,Clock24[1,2,3].min())
    assert_equal(2,Clock12[:AM,1,2,3].min())
    assert_equal(2,ClockSec[3723].min())
    
    ##### sec #####
    
    assert_equal(3,Clock24[1,2,3].sec())
    assert_equal(3,Clock12[:AM,1,2,3].sec())
    assert_equal(3,ClockSec[3723].sec())

    ##### day_sec #####
    
    assert_equal(3723,Clock24[1,2,3].day_sec())
    assert_equal(3723,Clock12[:AM,1,2,3].day_sec())
    assert_equal(3723,ClockSec[3723].day_sec())
    
    
    ##### to_s Methoden #####
    
    assert_equal("ClockSec[5]",ClockSec[5].to_s)
    assert_equal("Clock12[AM,1,2,3]",Clock12[:AM,1,2,3].to_s)
    assert_equal("Clock24[1,2,3]",Clock24[1,2,3].to_s)
  end
end
