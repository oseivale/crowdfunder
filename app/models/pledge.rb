class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :check_owner

  def check_owner
    errors.add(:user, "Owner should not be able to pledge towards own project") if self.user == project.user
  end
end
