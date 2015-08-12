# spec/models/raffle.rb
require 'rails_helper'
require 'factory_girl_rails'


describe Raffle, 'validation' do
  it "has a valid factory" do
    FactoryGirl.create(:raffle).should be_valid
  end
  it "is invalid without a title" do
    FactoryGirl.build(:raffle, title: nil).should_not be_valid
  end
  it "is invalid without a num_winners" do
    FactoryGirl.build(:raffle, num_winners: nil).should_not be_valid
  end
end
