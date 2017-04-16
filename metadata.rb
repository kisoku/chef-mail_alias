name             'mail_alias'
maintainer       'Mathieu Sauve-Frankel'
maintainer_email 'msf@kisoku.net'
license          'Apache-2.0'
description      'mail_alias provider'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'minitest-handler'

%w(
  amazon
  centos
  debian
  fedora
  redhat
  scientific
  oracle
  ubuntu
).each do |os|
  supports os
end

source_url 'https://github.com/kisoku/chef-mail_alias' if respond_to?(:source_url)
issues_url 'https://github.com/kisoku/chef-mail_alias/issues' if respond_to?(:issues_url)
chef_version '>= 12.1' if respond_to?(:chef_version)
