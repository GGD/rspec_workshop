require 'rails_helper'

module API
  module V1
    describe PostsController do
      describe 'GET #index' do
        it 'returns posts' do
          first_post = Post.create(title: 'first post', content: 'content')
          second_post = Post.create(title: 'second post', content: 'content')

          get :index

          expect(response).to have_http_status 200
          post_ids = json_response.map { |post| post[:id] }
          expect(post_ids).to contain_exactly(first_post.id, second_post.id)
        end
      end

      describe 'GET #show' do
        it 'returns the post' do
          post = Post.create(title: 'title', content: 'content')

          get :show, params: { id: post.id }

          expect(response).to have_http_status 200
          expect(json_response[:id]).to eq post.id
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'returns the created post' do
            post_params = { title: 'my title', content: 'content' }

            post :create, params: { post: post_params }

            expect(response).to have_http_status 201
            expect(json_response[:title]).to eq 'my title'
          end
        end

        context 'with invalid params' do
          it 'returns errors' do
            post_params = { title: 'my title', content: '' }

            post :create, params: { post: post_params }

            expect(response).to have_http_status 422
            expect(json_response[:content]).to include "can't be blank"
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          it 'returns the post' do
            post = Post.create(title: 'title', content: 'content')
            post_params = { title: 'new title', content: post.content }

            put :update, params: { id: post.id, post: post_params }

            expect(response).to have_http_status 200
            expect(json_response[:title]).to eq 'new title'
          end
        end

        context 'with invalid params' do
          it 'returns errors' do
            post = Post.create(title: 'title', content: 'content')
            post_params = { title: '', content: post.content }

            put :update, params: { id: post.id, post: post_params }

            expect(response).to have_http_status 422
            expect(json_response[:title]).to include "can't be blank"
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'returns nothing' do
          post = Post.create(title: 'title', content: 'content')

          delete :destroy, params: { id: post.id }

          expect(response).to have_http_status 204
          expect(response.body).to be_blank
        end
      end
    end
  end
end
