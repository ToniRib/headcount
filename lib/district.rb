class District
  attr_reader :name
  attr_accessor :enrollment, :statewide_test, :economic_profile

  def initialize(name_hash)
    @name = name_hash[:name].upcase
  end
end
