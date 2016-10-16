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


  it "Access MongoDB on Heroku" do
    puts Gem.loaded_specs["mongo"].version

    mongo_uri = ENV['MONGODB_URI']
    client = Mongo::Client.new(mongo_uri)
    db = client.database
    db.collection_names.each{|name| puts name }

    collection = client[:battles]
    result = collection.insert_one({code: 'ttt', opponent_name: 'ちょー', base_count: 10})
    p result
    expect(result.n).to eq 1  # insertした件数

  end
 end