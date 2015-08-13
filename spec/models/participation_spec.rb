# spec/models/raffle.rb
require 'rails_helper'
require 'factory_girl_rails'


describe Participation, 'validation' do
  it "has a valid factory" do
    FactoryGirl.create(:participation).should be_valid
  end



  it { should belong_to(:contestant) }

  it { should belong_to(:raffle) }

end
