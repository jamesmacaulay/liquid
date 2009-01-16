require File.dirname(__FILE__) + '/helper'
   
class RegexpTest < Test::Unit::TestCase
  include Liquid

  def test_empty
    assert_equal [], ''.scan(QuotedFragment)
  end
  
  def test_quote
    assert_equal ['"arg 1"'], '"arg 1"'.scan(QuotedFragment)
  end
  

  def test_words
    assert_equal ['arg1', 'arg2'], 'arg1 arg2'.scan(QuotedFragment)
  end

  def test_quoted_words
    assert_equal ['arg1', 'arg2', '"arg 3"'], 'arg1 arg2 "arg 3"'.scan(QuotedFragment)
  end

  def test_quoted_words
    assert_equal ['arg1', 'arg2', "'arg 3'"], 'arg1 arg2 \'arg 3\''.scan(QuotedFragment)
  end

  def test_quoted_words_in_the_middle
    assert_equal ['arg1', 'arg2', '"arg 3"', 'arg4'], 'arg1 arg2 "arg 3" arg4   '.scan(QuotedFragment)
  end
  
  def test_variable_parser
    assert_equal ['var'],                 'var'.scan(VariableParser)
    assert_equal ['var', 'method'],       'var.method'.scan(VariableParser)
    assert_equal ['var', '[method]'],       'var[method]'.scan(VariableParser)
    assert_equal ['var', '[method]', '[0]'],  'var[method][0]'.scan(VariableParser)
    assert_equal ['var', '["method"]', '[0]'],  'var["method"][0]'.scan(VariableParser)
    assert_equal ['var', '[method]', '[0]', 'method'],  'var[method][0].method'.scan(VariableParser)
    assert_equal ['var', '["method"]', '[0]', 'method'],  'var["method"][0].method'.scan(VariableParser)
    assert_equal ['var', '["me thod"]', '[0]', 'method'],  'var["me thod"][0].method'.scan(VariableParser)
  end
  
  def test_expression_with_blank_strings
    assert_equal ['" "'], '" "'.scan(Expression)
    assert_equal ['""'],  '""'.scan(Expression)
  end
  
  def test_cycle_named_syntax_with_colons_before_quoted_fragments
    assert_equal [['blah', '"foo"']], 'blah: "foo"'.scan(Cycle::NamedSyntax)
    assert_equal [['"blah"', '"bar", "baz"']],  '"blah" :"bar", "baz"'.scan(Cycle::NamedSyntax)
  end
  
  def test_cycle_named_syntax_with_colons_in_quoted_fragments
    assert_equal [], '"a:b c", "foo"'.scan(Cycle::NamedSyntax)
    assert_equal [],  '"foo", " d:e"'.scan(Cycle::NamedSyntax)
  end
 
end