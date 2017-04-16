if defined?(ChefSpec)
  def create_mail_alias(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:mail_alias, :create, resource_name)
  end
end
