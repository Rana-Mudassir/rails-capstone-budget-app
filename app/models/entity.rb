class Entity < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates :amount, presence: true
end
