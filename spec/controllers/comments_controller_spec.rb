require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:valid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }
  let(:invalid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("user", "pass") }
  let(:article) { create(:article) }

  describe 'POST #create' do
    subject { post :create, params: {
      comment: {
        commenter: "Dima",
        body: "some comment body",
        status: "public"
      },
      article_id: article.id
    } }

    context "with valid credentials" do
      before do
        request.headers['Authorization'] = valid_credentials
      end
      it { is_expected.to have_http_status(302) }
    end

    context "with invalid credentials" do
      before do
        request.headers['Authorization'] = invalid_credentials
      end
      it { is_expected.to have_http_status(401) }
    end
  end

  describe "DELETE #destroy" do
    let(:comment) { create(:comment, :article => article) }
    subject { post :destroy, params: {
      id: comment.id,
      article_id: article.id
    } }

    context "with valid credentials" do
      before do
        request.headers['Authorization'] = valid_credentials
      end
      it { is_expected.to have_http_status(303) }
    end

    context "with invalid credentials" do
      before do
        request.headers['Authorization'] = invalid_credentials
      end
      it { is_expected.to have_http_status(401) }
    end
  end
end