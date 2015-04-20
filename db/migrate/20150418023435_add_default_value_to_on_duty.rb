class AddDefaultValueToOnDuty < ActiveRecord::Migration
  def up
    change_column :responders, :on_duty, :boolean, default: false
  end

  def down
    change_column :responders, :on_duty, :boolean, default: nil
  end
end
