class Comment < ApplicationRecord
  validates :text, presence: true
  validates :task_id, presence: true
  validates :user_id, presence: true
  belongs_to :task
  belongs_to :user
end
