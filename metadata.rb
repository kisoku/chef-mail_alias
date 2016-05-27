name             'mail_alias'
maintainer       'Mathieu Sauve-Frankel'
maintainer_email 'msf@kisoku.net'
license          'Apache 2.0'
description      'mail_alias provider'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'minitest-handler'

source_url 'https://github.com/kisoku/chef-mail_alias' if respond_to?(:source_url)
issues_url 'https://github.com/kisoku/chef-mail_alias/issues' if respond_to?(:issues_url)
