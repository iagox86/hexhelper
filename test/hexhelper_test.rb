# Encoding: ASCII-8BIT
require 'test_helper'
require 'hexhelper'

class HexTestToS < ::Test::Unit::TestCase
  def test_empty_string()
    str = HexHelper.to_s('')
    assert_equal('', str)
  end

  def test_one_character_string()
    str = HexHelper.to_s('A')
    assert_equal('00000000  41                                                A', str)
  end

  def test_sixteen_character_string()
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA')
    assert_equal('00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA', str)
  end

  def test_more_than_sixteen()
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA')
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41                                       AAAA", str)
  end

  def test_null_bytes()
    str = HexHelper.to_s("A\0A\0A")
    assert_equal('00000000  41 00 41 00 41                                    A.A.A', str)
  end

  def test_newlines()
    str = HexHelper.to_s("A\nA\nA")
    assert_equal('00000000  41 0a 41 0a 41                                    A.A.A', str)
  end

  def test_exactly_thirty_two()
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA", str)
  end

  def test_indent()
    str = HexHelper.to_s('A', indent: 1)
    assert_equal(' 00000000  41                                                A', str)
  end

  def test_indent_two_lines()
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', indent: 2)
    assert_equal("  00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "  00000010  41 41 41 41                                       AAAA", str)
  end

  def test_indent_with_sixteen_characters()
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA', indent: 2)
    assert_equal('  00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA', str)
  end

  def test_offset()
    # Start
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 0)
    assert_equal("00000000 <41>41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41                                       AAAA", str)

    # Start of line
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 16)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010 <41>41 41 41                                       AAAA", str)

    # Middle of line
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 8)
    assert_equal("00000000  41 41 41 41 41 41 41 41<41>41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41                                       AAAA", str)

    # End of line
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 15)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41<41>  AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41                                       AAAA", str)

    # Partial block
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 18)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41<41>41                                       AAAA", str)

    # End
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 19)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41<41>                                      AAAA", str)

    # Past the end
    str = HexHelper.to_s('AAAAAAAAAAAAAAAAAAAA', offset: 20)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA\n" +
                 "00000010  41 41 41 41                                       AAAA", str)

    # Total length a multiple of 16, start
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA', offset: 0)
    assert_equal("00000000 <41>41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA", str)

    # Total length a multiple of 16, middle
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA', offset: 8)
    assert_equal("00000000  41 41 41 41 41 41 41 41<41>41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA", str)

    # Total length a multiple of 16, end
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA', offset: 15)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41<41>  AAAAAAAAAAAAAAAA", str)

    # Total length a multiple of 16, off-the-end
    str = HexHelper.to_s('AAAAAAAAAAAAAAAA', offset: 16)
    assert_equal("00000000  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41   AAAAAAAAAAAAAAAA", str)
  end
end
