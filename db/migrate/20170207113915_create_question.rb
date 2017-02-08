class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user, index: true
      t.string :question_text

      t.timestamps      
    end
  end
end
