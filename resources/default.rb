actions :create
default_action :create

attribute :alias_file, kind_of: String, default: '/etc/aliases'
attribute :recipients, kind_of: [String, Array], required: true
