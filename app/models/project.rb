class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validate :project_start_not_in_past
  validate :project_end_date_later_than_start_date

  def project_start_not_in_past
    if start_date <= Date.today
      errors.add(:project, "Error! Cannot create project in the past.")
    end
  end

  def project_end_date_later_than_start_date
    if end_date < start_date
      errors.add(:project, "Error! You cannot create an end date earlier than your start date.")
    end
  end
end
