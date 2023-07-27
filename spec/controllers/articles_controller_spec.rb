require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do
  let(:valid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }
  let(:invalid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("user", "pass") }

  describe "GET #index" do
    subject { get :index }

    it { is_expected.to be_ok }
  end

  describe "GET #show" do
    subject { get :show, params: { id: article.id } }

    let(:article) { create(:article) }

    it { is_expected.to be_ok }
  end

  describe "POST #create" do
    subject do
      post :create, params: {
        article: {
          title: "article title",
          body: "some example body",
          status: "public"
        }
      }
    end

    context "with valid credentials" do
      before { request.headers['Authorization'] = valid_credentials }

      it { is_expected.to have_http_status(302) }
    end

    context "with invalid credentials" do
      before { request.headers['Authorization'] = invalid_credentials }

      it { is_expected.to have_http_status(401) }
    end
  end

  describe "PUT #update" do
    subject do
      put :update,
          params: {
            id: article.id,
            article: {
              title: "article title",
              body: "some example body",
              status: "public"
            }
          }
    end

    let(:article) { create(:article) }

    context "with valid credentials" do
      before { request.headers['Authorization'] = valid_credentials }

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
    subject do
      put :destroy, params: {
        id: article.id
      }
    end

    let(:article) { create(:article) }

    context "with valid credentials" do
      before { request.headers['Authorization'] = valid_credentials }

      it { is_expected.to have_http_status(302) }
    end

    context "with invalid credentials" do
      before { request.headers['Authorization'] = invalid_credentials }

      it { is_expected.to have_http_status(401) }
    end
  end
end
