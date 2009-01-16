#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.dirname(__FILE__)+ '/extra')

require 'test/unit'
require 'test/unit/assertions'
require 'caller'
require 'breakpoint'
require File.dirname(__FILE__) + '/../lib/liquid'

# require 'rubygems'
# require 'ruby-debug'

module Test
  module Unit
    module Assertions
        include Liquid
        def assert_template_result(expected, template, assigns={}, message=nil)
          assert_equal expected, Template.parse(template).render(assigns)
        end 
    end
  end
end