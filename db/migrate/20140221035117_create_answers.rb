class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|

      t.belongs_to  :user
      t.belongs_to  :question

      t.text        :body
      t.integer     :vote_count, :default => 1

      t.timestamps
    end
  end
end
