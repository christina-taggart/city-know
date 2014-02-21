require 'spec_helper'

describe Post do
	it { should belong_to(:city) }
	it { should belong_to(:user) }
	it { should validate_presence_of :title }
	it { should validate_presence_of :body }

	it "gets initialized with one vote" do
		post = Post.create(title: "test title", body: "test body")
		expect(post.vote_count).to eq 1
	end

end