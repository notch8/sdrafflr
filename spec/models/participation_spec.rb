# spec/models/raffle.rb
require 'rails_helper'
require 'factory_girl_rails'


describe Participation, 'validation' do
  it "has a valid factory" do
    FactoryGirl.create(:participation).should be_valid
  end

  it { should allow_value(true).for(:winner) }

  it { should allow_value(false).for(:winner) }

  it { should_not allow_value(nil).for(:winner) }

  it { should validate_presence_of(:raffle_id) }

  it { should validate_presence_of(:contestant_id) }

  it { should belong_to(:contestant) }

  it { should belong_to(:raffle) }

end
