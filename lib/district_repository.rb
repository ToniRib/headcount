require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'data_formattable'
require_relative 'statewide_testing_repository'
require_relative 'economic_profile_repository'

class DistrictRepository
  include DataFormattable

  attr_reader :districts, :enrollment_repo, :statewide_test_repo,
              :economic_profile_repo

  def initialize
    @districts = {}
    @enrollment_repo = EnrollmentRepository.new
    @statewide_test_repo = StatewideTestRepository.new
    @economic_profile_repo = EconomicProfileRepository.new
  end

  def district_names_across_repositories
    enroll_names = enrollment_repo.enrollments.keys
    statewidetest_names = statewide_test_repo.statewide_tests.keys
    profile_names = economic_profile_repo.profiles.keys

    (enroll_names | statewidetest_names | profile_names).map(&:upcase)
  end

  def load_data(options)
    options = nil_key_return_empty_hash(options)

    load_data_into_repositories(options)

    district_names_across_repositories.each do |name|
      create_district_with_data(name)
    end
  end

  def load_data_into_repositories(options)
    enrollment_repo.load_data(enrollment_data(options))
    statewide_test_repo.load_data(statewide_test_data(options))
    economic_profile_repo.load_data(economic_profile_data(options))
  end

  def enrollment_data(options)
    { enrollment: options[:enrollment] }
  end

  def statewide_test_data(options)
    { statewide_testing: options[:statewide_testing] }
  end

  def economic_profile_data(options)
    { economic_profile: options[:economic_profile] }
  end

  def create_district_with_data(name)
    district = District.new(name: name)

    district.enrollment = enrollment_repo.find_by_name(name)
    district.statewide_test = statewide_test_repo.find_by_name(name)
    district.economic_profile = economic_profile_repo.find_by_name(name)

    districts[name] = district
  end

  def find_by_name(district_name)
    if district_exists?(district_name)
      districts[district_name.upcase]
    else
      fail UnknownDataError, 'District not found'
    end
  end

  def district_exists?(district_name)
    districts.key?(district_name.upcase)
  end

  def find_all_matching(str)
    districts.select { |name, _| name.start_with?(str.upcase) }.values
  end
end
