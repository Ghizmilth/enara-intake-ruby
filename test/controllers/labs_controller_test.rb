require 'test_helper'

class LabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lab = labs(:one)
  end

  test "should get index" do
    get labs_url
    assert_response :success
  end

  test "should get new" do
    get new_lab_url
    assert_response :success
  end

  test "should create lab" do
    assert_difference('Lab.count') do
      post labs_url, params: { lab: { Glucose_SerPI_mCnc: @lab.Glucose_SerPI_mCnc, HDLc_SerPI_mCnc: @lab.HDLc_SerPI_mCnc, HSCRP: @lab.HSCRP, Hgb_A1c_MFr_Bld: @lab.Hgb_A1c_MFr_Bld, LDLc_SerPI_Calc_mCnc: @lab.LDLc_SerPI_Calc_mCnc, Trigl_SerPI_mCnc: @lab.Trigl_SerPI_mCnc, VLDL: @lab.VLDL, chart_id: @lab.chart_id, cholest_SerPI_mCnc: @lab.cholest_SerPI_mCnc, notes: @lab.notes, received_date: @lab.received_date, reported_date: @lab.reported_date, source: @lab.source } }
    end

    assert_redirected_to lab_url(Lab.last)
  end

  test "should show lab" do
    get lab_url(@lab)
    assert_response :success
  end

  test "should get edit" do
    get edit_lab_url(@lab)
    assert_response :success
  end

  test "should update lab" do
    patch lab_url(@lab), params: { lab: { Glucose_SerPI_mCnc: @lab.Glucose_SerPI_mCnc, HDLc_SerPI_mCnc: @lab.HDLc_SerPI_mCnc, HSCRP: @lab.HSCRP, Hgb_A1c_MFr_Bld: @lab.Hgb_A1c_MFr_Bld, LDLc_SerPI_Calc_mCnc: @lab.LDLc_SerPI_Calc_mCnc, Trigl_SerPI_mCnc: @lab.Trigl_SerPI_mCnc, VLDL: @lab.VLDL, chart_id: @lab.chart_id, cholest_SerPI_mCnc: @lab.cholest_SerPI_mCnc, notes: @lab.notes, received_date: @lab.received_date, reported_date: @lab.reported_date, source: @lab.source } }
    assert_redirected_to lab_url(@lab)
  end

  test "should destroy lab" do
    assert_difference('Lab.count', -1) do
      delete lab_url(@lab)
    end

    assert_redirected_to labs_url
  end
end
