class CreateVoteQuestion < ActiveRecord::Migration
  def change
    create_table :vote_questions do |t|
      t.belongs_to :question, index: true
      t.boolean :type_vote
      t.timestamps      
    end
  end
end
