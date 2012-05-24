include_recipe "minitest-handler" 

mail_alias "test_string" do
  recipients "string_recipient"
end

mail_alias "test_array" do
  recipients %w[ary1 ary2]
end

mail_alias "test_multiple1" do
  recipients "m1_1" 
end

mail_alias "test_multiple1" do
  recipients "m1_2" 
end

mail_alias "test_multiple2" do
  recipients %w[m2_1 m2_2]
end

mail_alias "test_multiple2" do
  recipients %w[m2_3 m2_4]
end
