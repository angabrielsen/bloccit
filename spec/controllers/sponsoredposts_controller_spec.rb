require 'rails_helper'
include RandomData

RSpec.describe SponsoredpostsController, type: :controller do
	let (:my_sponsoredpost) {Sponsoredpost.create(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99)}

	describe "GET index" do
		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end

		it "assigns my_sponsoredpost to @sponsoredposts" do
			get :index
			expect(assigns(:sponsoredposts)).to eq([my_sponsoredpost])
		end
	end

	describe "GET show" do
		it "returns http success" do
			get :show, {id: my_sponsoredpost.id}
			expect(response).to have_http_status(:success)
		end

		it "renders the #show view" do
			get :show, {id: my_sponsoredpost.id}
			expect(response).to renders_template :show
		end

		it "assigns my_sponsoredpost to @sponsoredpost" do
			get :show, {id: my_sponsoredpost.id}
			expect(assigns(:sponsoredpost)).to eq(my_sponsoredpost)
		end
	end

	describe "GET new" do
		it "returns http success" do
			get :new
			expect(response).to have_http_status(:success)
		end

		it "renders the #new view" do
			get :new
			expect(response).to render_template :new
		end

		it "initializes @sponsoredpost" do
			get :new
			expect(assigns(:sponsoredpost)).not_to be_nil
		end
	end

	describe "POST create" do
		it "increases the number of Sponsoredpost by 1" do
			expect{post :create, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Sponsoredpost, :count).by(1)
		end

		it "assigns the new sponsored post to @sponsoredpost" do
			post :create, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
		end

		it "redirects to the new post" do
			post :create, topic_id: my_sponsoredpost.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        	expect(response).to redirect_to [Sponsoredpost.last]
		end
	end

	describe "GET edit" do
		it "returns http success" do
			get :edit, {id: my_sponsoredpost.id}
			expect(response).to have_http_status(:success)
		end

		it "renders the #edit view" do
			get :edit, {id: my_sponsoredpost.id}
			expect(response).to render_template :edit
		end

		it "assigns topic to be updated to @topic" do
			get :edit, {id: my_sponsoredpost.id}
			topic_instance = assigns(:sponsoredpost)

			expect(sponsoredtopic_instance.id).to eq my_sponsoredtopic.id
			expect(sponsoredtopic_instance.name).to eq my_sponsoredtopic.name
			expect(sponsoredtopic_instance.description).to eq my_sponsoredtopic.body
		end
	end
end