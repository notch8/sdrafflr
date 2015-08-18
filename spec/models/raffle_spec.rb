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

  it "is invalid if num_winners is not an integer" do
    FactoryGirl.build(:raffle, num_winners: "one").should_not be_valid
  end

  it "is valid if num_winners is an integer" do
    FactoryGirl.build(:raffle, num_winners: 1).should be_valid
  end


  it { should have_many(:participations) }

  it { should have_many(:contestants) }

  it{ expect(Winner.count).to eql(1)}


end
