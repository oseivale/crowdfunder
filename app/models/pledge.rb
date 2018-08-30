class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward

  validates :dollar_amount, presence: true
  validates :dollar_amount, numericality: {greater_than: 0}
  validates :user, presence: true
  validate :check_owner
  validate :check_date

  def check_owner
    errors.add(:user, " should not be able to pledge towards own project") if self.user == project.user
  end

  def check_date
    errors.add(:user, " cannot pledge before the project's start date") if project.start_date > Date.today
  end

end
