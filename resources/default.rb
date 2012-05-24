actions :create

attribute :alias_file, :kind_of => String, :default => "/etc/aliases"
attribute :recipients, :kind_of => [ String, Array ], :required => true

def initialize(*args)
  super
  @action = :create
end
