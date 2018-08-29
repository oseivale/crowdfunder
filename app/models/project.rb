class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user_id, presence: true
  validate :project_start_not_in_past
  validate :project_end_date_later_than_start_date
  validates :goal, numericality: {greater_than: 0}

  def self.with_pledges
    self.joins(:pledges).uniq
  end

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

  # calculate total $$ pledged, should be tested
  def total_pledged
    total = 0
    self.pledges.each do |pledge|
      total += pledge.dollar_amount
    end
    return total
  end

  # check if user has backed/pledged this project
  def backer(user)
    self.pledges.each do |pledge|
      return true if pledge.user == user
    end
    return false
  end

  # calculate total user has pledged for this project
  def backer_pledged(user)
    total = 0
    self.pledges.each do |pledge|
      if pledge.user == user
        total += pledge.dollar_amount
      end
    end
    return total
  end
end
