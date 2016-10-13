require 'rails_helper'
# include BattlesHelper

RSpec.describe BattlesHelper, type: :helper do

  it "#convert_refreshed_time" do
    dt = Time.zone.local(2016, 1, 2, 3, 4, 5)
    expect(helper.convert_refreshed_time(dt)).to eq "03:04:05"
    expect(helper.convert_refreshed_time(nil)).to be_nil
  end

  it "#convert_reserved_datetime_string" do
    dt = Time.zone.local(2016, 1, 21, 3, 4, 5)
    expect(helper.convert_reserved_datetime_string(dt)).to eq "1月21日 03:04"

  end
 end