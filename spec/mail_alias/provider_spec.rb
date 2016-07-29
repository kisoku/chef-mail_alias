require File.join(File.dirname(__FILE__), %w(.. spec_helper))
# require 'spec_helper'
cb_root = File.join(File.dirname(__FILE__), %w(.. ..))

describe 'MailAlias::Resource::Default' do
  before do
    Chef::Resource::LWRPBase.build_from_file('mail_alias', File.join(cb_root, 'resources', 'default.rb'), nil)
  end

  it 'should load the resource into a properly named class' do
    expect(Chef::Resource.const_get('MailAlias').class).to eq(Class)
  end
end

describe 'MailAlias::Provider::Default' do
  before do
    Chef::Resource::LWRPBase.build_from_file('mail_alias', File.join(cb_root, 'resources', 'default.rb'), nil)
    Chef::Provider::LWRPBase.build_from_file('mail_alias', File.join(cb_root, 'providers', 'default.rb'), nil)
  end

  let(:runner) { ChefSpec::SoloRunner.new.converge }

  it 'should properly handle a new_resource reference' do
    resource = Chef::Resource::MailAlias.new('test_alias')
    resource.alias_file(File.join(File.dirname(__FILE__), %w(tmp aliases)))
    resource.recipients(%w(test_recipient))
    resource.run_context = runner.run_context

    provider = resource.provider_for_action(:create)
    expect(provider.class).to eq(Chef::ProviderResolver.new(runner.node, provider.class, :create).resource)
  end
end
