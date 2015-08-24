# spec/models/raffle.rb
require 'rails_helper'
require 'factory_girl_rails'
require 'faker'

describe Raffle, 'validation' do
  it "has a valid factory" do
    FactoryGirl.create(:raffle).should be_valid
  end
  it "is invalid without a title" do
    FactoryGirl.build(:raffle, title: nil).should_not be_valid
  end

  # it { should validate_numericality_of(:num_winners).only_integer }

  it { should validate_presence_of(:title) }

  it { should have_many(:participations) }

  it { should have_many(:contestants) }

end
