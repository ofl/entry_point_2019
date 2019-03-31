require 'rails_helper'

RSpec.describe VueArticlesController, type: :controller do
  include_context :gon

  let(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    { title: 'foo', body: 'bar' }
  }

  let(:invalid_attributes) {
    { title: '', body: '' }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Article.create! valid_attributes.merge(user: user)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end

    it 'gonifies as expected' do
      article = Article.create! valid_attributes.merge(user: user)
      get :index, params: {}, session: valid_session

      expect(gon['articles'][0]).to eq(
        {
          commentsCount: 0,
          createdAt: article.created_at.xmlschema,
          id: article.id.to_s,
          likesCount: 0,
          title: article.title,
          user: {
            __typename: 'User',
            avatarUrl: nil,
            id: user.id.to_s,
            name: user.name
          }.stringify_keys
        }.stringify_keys
      )
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      article = Article.create! valid_attributes.merge(user: user)
      get :show, params: { id: article.to_param }, session: valid_session
      expect(response).to be_successful
    end

    it 'gonifies as expected' do
      article = Article.create! valid_attributes.merge(user: user)
      get :show, params: { id: article.to_param }, session: valid_session

      expect(gon['article']).to eq(
        {
          body: article.body,
          comments: [],
          commentsCount: 0,
          createdAt: article.created_at.xmlschema,
          id: article.id.to_s,
          likedByMe: false,
          likesCount: 0,
          title: article.title,
          user: {
            __typename: 'User',
            avatarUrl: nil,
            id: user.id.to_s,
            name: user.name
          }.stringify_keys
        }.stringify_keys
      )
    end
  end

  describe 'GET #new' do
    before do
      login_user(user)
    end

    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    before do
      login_user(user)
    end

    it 'returns a success response' do
      article = Article.create! valid_attributes.merge(user: user)
      get :edit, params: { id: article.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      login_user(user)
    end

    context 'with valid params' do
      it 'creates a new Article' do
        expect {
          post :create, params: { article: valid_attributes }, session: valid_session
        }.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        post :create, params: { article: valid_attributes }, session: valid_session
        expect(response).to redirect_to(vue_article_url(Article.last))
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { article: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    before do
      login_user(user)
    end

    context 'with valid params' do
      let(:new_attributes) {
        { body: 'baz' }
      }

      it 'updates the requested article' do
        article = Article.create! valid_attributes.merge(user: user)
        put :update, params: { id: article.to_param, article: new_attributes }, session: valid_session
        article.reload
        expect(article.body).to eq 'baz'
      end

      it 'redirects to the article' do
        article = Article.create! valid_attributes.merge(user: user)
        put :update, params: { id: article.to_param, article: valid_attributes }, session: valid_session
        expect(response).to redirect_to(vue_article_url(article))
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        article = Article.create! valid_attributes.merge(user: user)
        put :update, params: { id: article.to_param, article: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_user(user)
    end

    it 'destroys the requested article' do
      article = Article.create! valid_attributes.merge(user: user)
      expect {
        delete :destroy, params: { id: article.to_param }, session: valid_session
      }.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      article = Article.create! valid_attributes.merge(user: user)
      delete :destroy, params: { id: article.to_param }, session: valid_session
      expect(response).to redirect_to(vue_articles_url)
    end
  end
end
