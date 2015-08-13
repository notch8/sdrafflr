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

  it { should have_many(:participations) }

  it { should have_many(:contestants) }

  describe "with contestants" do
    let(:contestant1){FactoryGirl.create(:contestant)}
    let(:contestant2){FactoryGirl.create(:contestant)}
    let(:raffle){FactoryGirl.create(:raffle)}
    let!(:paticipation1){FactoryGirl.create(:participation, contestant: contestant1, raffle: raffle)}
    let!(:paticipation2){FactoryGirl.create(:participation, contestant: contestant2, raffle: raffle)}

    it "should assign two winners" do
      raffle.num_winners = 2
      expect(raffle.pick_winners.length).to eq(2)
    end

    it "should update winning participations" do
      expect(raffle.pick_winners.first.winner).to eq true
    end
  end

end
