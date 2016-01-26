require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

  context "unauthenticated user" do
    it "PUT update returns http unauthenticated" do
      post :update, topic_id: my_topic.id, id: my_post.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(401)
    end
  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "PUT update returns http success" do
      put :update, id: my_post.id, title: RandomData.random_sentence, body: RandomData.random_paragraph
      expect(response).to have_http_status(403)
    end

    it "DELETE destroy returns http forbidden" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(403)
    end
  end

  context "authenticated and authorized users" do
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      @new_post = build(:topic)
      end

      describe "PUT update" do
      before { put :update, topic_id: my_topic.id, id: my_post.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph} }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "updates a topic with the correct attributes" do
        updated_post = Post.find(my_post.id)
        expect(updated_post.to_json).to eq response.body
      end
    end

    describe "DELETE destroy" do
      before { delete :destroy, id: my_post.id }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "returns the correct json success message" do
        expect(response.body).to eq({"message" => "Post destroyed","status" => 200}.to_json)
      end

      it "deletes my topic" do
        expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end



describe Api::V1::PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:new_post) { build(:post) } # just a vessel to hold values; not saved

  describe "POST create" do
    let(:request) { post :create, topic_id: topic.id, post: {title: new_post.title, body: new_post.body} }

    context "when logged in as an admin" do
      before do
        user.admin!
        controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)
      end

      describe "returns" do
        it "http success" do
          request
          expect(response).to have_http_status(:success)
        end

        it "json content type" do
          request
          expect(response.content_type).to eq 'application/json'
        end

        it "a json representation of the created post" do
          request
          hashed_json = JSON.parse(response.body)
          expect(hashed_json["title"]).to eq new_post.title
          expect(hashed_json["body"]).to eq new_post.body
        end
      end

      describe "as a side-effect" do
        it "creates a post" do
          expect{request}.to change(Post, :count).by(1)
          # aka
          # pre_count = Post.count
          # request
          # post_count = Post.count
          # expect(post_count).to eq(pre_count + 1)
        end

        it "creates a post with the correct attributes" do
          request
          post = Post.last
          expect(post.title).to eq new_post.title
          expect(post.body).to eq new_post.body
        end
      end
    end
  end
end