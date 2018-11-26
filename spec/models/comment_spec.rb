require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:title) { 'Some comment' }
  let(:contents) { 'test' }
  let(:movie) { Movie.new(title: 'Wonder Woman') }
  let(:user) { User.new(email: 'example@gmail.com', password: 'password') }

  subject { Comment.new(title: title, contents: contents, movie_id: movie, user: user) }

  context 'with incomplete data' do
    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without contents' do
      subject.contents = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without movie_id' do
      subject.movie_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end
