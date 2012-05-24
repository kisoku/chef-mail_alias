class AliasesTest < MiniTest::Chef::TestCase

  def assert_alias(name, recipients)
      f = IO.read("/etc/aliases")
      assert_match(/^#{name}: #{recipients.join(", ")}$/, f)
  end

  def test_string
      assert_alias "test_string", %w[string_recipient]
  end

  def test_array
      assert_alias "test_array", %w[ary1 ary2]
  end

  def test_multiple1
      assert_alias "test_multiple1", %w[m1_1 m1_2]
  end

  def test_multiple2
      assert_alias "test_multiple2", %w[m2_1 m2_2 m2_3 m2_4]
  end
end
