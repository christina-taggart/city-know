require 'spec_helper'
describe PostsController do
	it "should create a url when passed valid parameters" do
		expect {
			post :create, :city_id => 1, :post => { title: "test", body: "test body" }
		}.to change {Post.count}.by 1
	end
end