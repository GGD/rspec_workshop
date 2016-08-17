require 'rails_helper'

module API
  module V1
    describe PostsController do
      describe 'GET #index' do
        subject { get :index }

        before do
          create(:post, title: 'first post')
          create(:post, title: 'second post')
        end

        it 'returns posts' do
          subject

          expect(response).to have_http_status 200
          post_titles = json_response.map { |post| post[:title] }
          expect(post_titles).to contain_exactly('first post', 'second post')
        end
      end

      describe 'GET #show' do
        subject { get :show, params: { id: post.id } }

        let(:post) { create(:post) }

        it 'returns the post' do
          subject

          expect(response).to have_http_status 200
          expect(json_response[:id]).to eq post.id
        end
      end

      describe 'POST #create' do
        subject { post :create, params: { post: post_params } }

        let(:post_params) { attributes_for(:post, title: 'my title') }

        context 'with valid params' do
          it 'returns the created post' do
            subject

            expect(response).to have_http_status 201
            expect(json_response[:title]).to eq 'my title'
          end
        end

        context 'with invalid params' do
          let(:post_params) { attributes_for(:post, content: '') }

          it 'returns errors' do
            subject

            expect(response).to have_http_status 422
            expect(json_response[:content]).to include "can't be blank"
          end
        end
      end

      describe 'PUT #update' do
        subject { put :update, params: { id: post.id, post: post_params } }

        let(:post) { create(:post) }
        let(:post_params) { attributes_for(:post, title: 'new title') }

        context 'with valid params' do
          it 'returns the post' do
            subject

            expect(response).to have_http_status 200
            expect(json_response[:title]).to eq 'new title'
          end
        end

        context 'with invalid params' do
          let(:post_params) { attributes_for(:post, title: '') }

          it 'returns errors' do
            subject

            expect(response).to have_http_status 422
            expect(json_response[:title]).to include "can't be blank"
          end
        end
      end

      describe 'DELETE #destroy' do
        subject { delete :destroy, params: { id: post.id } }

        let(:post) { create(:post) }

        it 'returns nothing' do
          subject

          expect(response).to have_http_status 204
          expect(response.body).to be_blank
        end
      end
    end
  end
end
