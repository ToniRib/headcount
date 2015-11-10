require 'minitest'
require 'headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  def kindergarten_test
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/kindergarten_tester.csv"
      }
    })
    HeadcountAnalyst.new(dr)
  end

  def test_class_exists
    assert HeadcountAnalyst
  end

  def test_can_find_enrollment_object_by_district_name
    ha = kindergarten_test
    enrollment = ha.find_enrollment_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", enrollment.name
    assert_equal 0.436, enrollment.kindergarten_participation_in_year(2010)

  end

  def test_calculates_kindergarten_participation_rate_variation
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
    assert_equal 0.837, var
  end

  def test_calculates_kindergarten_participation_rate_variation_down_case_second
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'Colorado')
    assert_equal 0.837, var
  end

  def test_calculates_kindergarten_participation_rate_variation_down_case_both
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation('Academy 20', :against => 'colorado')
    assert_equal 0.837, var
  end

  def test_calculates_kindergarten_participation_district_against_district
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
    assert_equal 0.620, var
  end

  def test_calculates_kindergarten_participation_district_against_district_reverse
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation('ADAMS COUNTY 14', :against => 'ACADEMY 20')
    assert_equal 1.612, var
  end

  def test_calculates_kindergarten_participation_rate_variation
    ha = kindergarten_test
    var = ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
    expected = {2007=>0.992, 2006=>"N/A", 2005=>0.96, 2004=>1.257,
                2008=>0.717, 2009=>0.652, 2010=>0.681}

    assert_equal expected, var
  end

  # def test_calculates_average_of_kindergarten_participation_by_district
  #   ha = kindergarten_test
  #
  #   ha.average('ACADEMY 20', :enrollment, :kindergarten_participation)
  # end


end
