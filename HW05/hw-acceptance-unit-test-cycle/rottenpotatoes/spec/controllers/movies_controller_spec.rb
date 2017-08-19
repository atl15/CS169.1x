require "rails_helper"

describe MoviesController do
  describe "find same director" do
    describe "movie has a director" do
      before :each do
        @fake_results = [double('movie1'), double('movie2')]
      end
      it 'calls the model method that performs same director search' do
        expect(Movie).to receive(:same_directors).with('George Lucas').
                                 and_return(@fake_results)
        get :find_same_director, id: 1
      end
      describe 'after valid search' do
        before :each do
          allow(Movie).to receive(:same_directors).and_return(@fake_results)
          get :find_same_director, id: 1
        end
        it 'selects the Search Results template for rendering' do
          expect(response).to render_template('find_same_director')
        end
        it 'makes the same director search results available for that template' do
          expect(assigns(:movies)).to eq(@fake_results)
        end
      end
    end
    describe "movie has no director" do
      it 'redirect to home page' do
        get :find_same_director, id: 3
        expect(response).to redirect_to(movies_path)
      end
      it 'show info that movie has no director' do
        get :find_same_director, id: 3
        expect(response).to redirect_to(movies_path)
        expect(flash[:notice]).to match /has no director info$/
      end

    end
  end

  # describe "CRUD" do
  #   fixtures :movies
  #   it "show movie with valid id" do
  #     movie_id = movies(:star_wars).id
  #     get :show, id: movie_id
  #     expect(response).to render_template('show')
  #   end
  # end
end
