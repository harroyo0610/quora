class CreateVoteAnswer < ActiveRecord::Migration
  def change
    create_table :vote_answers do |t|
      t.belongs_to :answer, index: true
      t.boolean :type_vote
      t.timestamps      
    end
  end
end
