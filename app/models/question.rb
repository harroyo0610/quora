class Question < ActiveRecord::Base
  has_many :vote_questions
  has_many :answers
end