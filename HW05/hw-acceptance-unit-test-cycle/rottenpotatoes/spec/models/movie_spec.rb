require "rails_helper"

describe Movie do
  describe "find movies with same director" do
    fixtures :movies
    it "should find movies be the same director" do
      movies = [movies(:star_wars), movies(:thx_1138)]
      expect(Movie.same_directors("George Lucas")).to eq(movies)
    end
    it "should not find movies be the same director" do
      expect(Movie.same_directors("foo bar")).to be_empty
    end
  end
end
