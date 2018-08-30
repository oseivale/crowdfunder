class ChangeTablePledgesBelongToReward < ActiveRecord::Migration[5.2]
  def change
    rename_column :pledges, :project_id, :reward_id
  end
end
