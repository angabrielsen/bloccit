require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  let(:sponsoredpost) {topic.sponsoredposts.create!(title:RandomData.random_sentence, body: RandomData.random_paragraph, price: 99)}

  it { should have_many(:posts) }
  it { should have_many(:labelings) }
  it { should have_many(:labels).through(:labelings) }
  it { should have_many(:sponsoredposts) }
    
  describe "attributes" do
  	it "should respond to name" do
  		expect(topic).to respond_to(:name)
  	end

  	it "should respond to description" do
  		expect(topic).to respond_to(:description)
  	end

  	it "should respond to public" do
  		expect(topic).to respond_to(:public)
  	end

  	it "should be public by default" do
  		expect(topic.public).to be(true)
  	end
  end
end