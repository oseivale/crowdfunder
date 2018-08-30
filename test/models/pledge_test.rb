require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  def test_a_pledge_can_be_created
    project = new_project
    project.start_date = Date.today - 1
    pledge = Pledge.create(
      dollar_amount: 99.00,
      project: project,
      user: new_user,
    )
    pledge.save
    assert pledge.valid?
    assert pledge.persisted?
  end

  def test_owner_cannot_back_own_project
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledge = Pledge.new(dollar_amount: 3.00, project: project)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
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

  def test_pledge_number_cannot_be_negative
    project = new_project
    pledge = Pledge.new(project: project, user: new_user, dollar_amount: -100)
    refute pledge.valid?
  end

  def test_pledge_cannot_be_made_before_start_date
    project = new_project
    pledge = Pledge.new(project: project, user: new_user, dollar_amount: 50)
    refute pledge.valid?
  end

end
