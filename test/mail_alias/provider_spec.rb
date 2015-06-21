require File.join(File.dirname(__FILE__), %w(.. spec_helper))

cb_root = File.join(File.dirname(__FILE__), %w(.. ..))

describe 'MailAlias::Resource::Default' do
  before do
    @node = Chef::Node.new
    @node.platform(:ubuntu)
    @node.platform_version('12.04')

    Chef::Resource.build_from_file('mail_alias', File.join(cb_root, 'resources', 'default.rb'), nil)
  end

  it 'should load the resource into a properly named class' do
    assert_kind_of Class, Chef::Resource.const_get('MailAlias')
  end
end

describe 'MailAlias::Provider::Default' do
  before do
    @node = Chef::Node.new
    @node.platform(:ubuntu)
    @node.platform_version('12.04')
    @run_context = Chef::RunContext.new(@node, Chef::CookbookCollection.new({}))
    @runner = Chef::Runner.new(@run_context)

    Chef::Resource.build_from_file('mail_alias', File.join(cb_root, 'resources', 'default.rb'), nil)
    Chef::Provider.build_from_file('mail_alias', File.join(cb_root, 'providers', 'default.rb'), nil)
  end

  it 'should properly handle a new_resource reference' do
    resource = Chef::Resource::MailAlias.new('test_alias')
    resource.alias_file(File.join(File.dirname(__FILE__), %w(tmp aliases)))
    resource.recipients(%w(test_recipient))
    resource.run_context = @run_context

    provider = Chef::Platform.provider_for_resource(resource)
    assert_kind_of Chef::Provider::MailAlias, provider
  end
end
