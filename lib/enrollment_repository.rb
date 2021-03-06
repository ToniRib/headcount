require_relative 'enrollment'
require_relative 'post_processor'

class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = {}
  end

  def load_data(options)
    post = PostProcessor.new
    data = post.get_enrollment_data(options)

    data.each_pair do |district_name, district_data|
      enrollment_options = { name: district_name.upcase }.merge(district_data)
      @enrollments[district_name.upcase] = Enrollment.new(enrollment_options)
    end
  end

  def find_by_name(district_name)
    @enrollments[district_name.upcase] if district_exists?(district_name)
  end

  def district_exists?(district_name)
    @enrollments.keys.include?(district_name.upcase)
  end
end
