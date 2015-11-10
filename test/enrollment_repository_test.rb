require 'minitest'
require 'enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  def kindergarten_test
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/kindergarten_tester.csv"
      }
    })
    er
  end

  def test_class_exists
    skip
    assert EnrollmentRepository
  end

  # def test_can_load_data_from_kindergarten_file
  #   skip # until we actually start setting District data
  #   dr = DistrictRepository.new
  #   data = dr.load_data(:kindergarten => "./test/fixtures/kindergarten_tester.csv")
  #
  #   expected_keys = ['COLORADO', 'ACADEMY 20', 'ADAMS COUNTY 14']
  #   assert_equal expected_keys, data.keys
  #
  #   expected_years = [2004, 2005, 2006, 2007, 2008, 2009, 2010]
  #   assert_equal expected_years, data['COLORADO'].keys.sort
  #
  #   assert_equal 0.24014, data['COLORADO'][2004]
  #
  #   assert_equal 'N/A', data['ADAMS COUNTY 14'][2005]
  # end
  #
  # def test_load_data_creates_district_objects
  #   dr = kindergarten_test
  #
  #   assert_equal 3, dr.districts.count
  #
  #   dr.districts.each do |name, value|
  #     assert value.is_a?(District)
  #   end
  #
  #   expected_keys = ['COLORADO', 'ACADEMY 20', 'ADAMS COUNTY 14']
  #   assert_equal expected_keys, dr.districts.keys
  # end
  #
  # def test_can_find_by_district_name
  #   dr = kindergarten_test
  #
  #   assert_equal "ACADEMY 20", dr.find_by_name("ACADEMY 20").name
  # end
  #
  # def test_can_find_by_other_district_name
  #   dr = kindergarten_test
  #
  #   assert_equal "COLORADO", dr.find_by_name("Colorado").name
  # end
  #
  # def test_gives_error_if_district_does_not_exist
  #   dr = kindergarten_test
  #
  #   refute dr.find_by_name("XYZ")
  # end
  #
  # def test_returns_true_if_district_exists
  #   dr = kindergarten_test
  #
  #   assert dr.district_exists?('Colorado')
  # end
  #
  # def test_returns_false_if_district_does_not_exist
  #   dr = kindergarten_test
  #
  #   refute dr.district_exists?('XYZ')
  # end
  #
  # def test_returns_empty_array_if_no_districts_include_fragment
  #   dr = kindergarten_test
  #
  #   assert_equal [], dr.find_all_matching('frank')
  # end
  #
  # def test_returns_district_objects_containing_fragment
  #   dr = kindergarten_test
  #
  #   districts = dr.find_all_matching('a')
  #
  #   assert_equal 'ACADEMY 20', districts[0].name
  #   assert_equal 'ADAMS COUNTY 14', districts[1].name
  # end
end
