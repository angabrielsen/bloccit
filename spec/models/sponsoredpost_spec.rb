require 'rails_helper'
include RandomData

RSpec.describe Sponsoredpost, type: :model do
	let(:sponsoredpost) { Sponsoredpost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99)}

	describe "attributes" do
		it "should respond to title" do
			expect(sponsoredpost).to respond_to(:title)
		end

		it "should respond to description" do
			expect(sponsoredpost).to respond_to(:body)
		end

		it "should respond to price" do
			expect(sponsoredpost).to respond_to(:price)
		end
	end
end
