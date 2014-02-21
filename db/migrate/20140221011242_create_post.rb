class CreatePost < ActiveRecord::Migration
  def change
  	create_table :posts do |t|

  		t.belongs_to 	:user
  		t.belongs_to 	:city

  		t.string 			:title
  		t.text 				:body
  		t.integer			:vote_count, :default => 1

  		t.timestamps
  	end
  end
end
