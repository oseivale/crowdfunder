require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def new_user
    User.destroy_all
    User.create(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today + 1.day,
      end_date:    Date.today + 1.month,
      goal:        50000,
      user_id:     new_user.id
    )
  end

  def test_project_is_valid
    project = new_project
    assert project.valid?
  end

  def test_valid_project_can_be_created
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  def test_project_is_invalid_without_owner
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end





  def test_project_start_cannot_be_in_past
    # project1 = Project.new(start_date: Date.today)
    project = new_project
    project.start_date = Date.today - 1.day
    assert project.invalid?
  end

  def test_project_end_date_cannot_be_earlier_than_start_date
    project = new_project
    project.end_date = project.start_date - 1.day
    assert project.invalid?
  end

  def test_project_goal_is_positive_number
    project = new_project
    project.goal = 10
    assert project.invalid?
  end
end
