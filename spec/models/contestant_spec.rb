# spec/models/raffle.rb
require 'rails_helper'
require 'factory_girl_rails'


describe Contestant, 'validation' do
  it "has a valid factory" do
    FactoryGirl.create(:contestant).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:contestant, name: nil).should_not be_valid
  end


  it { should have_many(:participations) }

  it { should have_many(:raffles) }

end
