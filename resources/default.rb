actions :create

attribute :recipients, :kind_of => [ String, Array ], :required => true

def initialize(*args)
  super
  @action = :create
end
