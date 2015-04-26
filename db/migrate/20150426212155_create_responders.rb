class CreateResponders < ActiveRecord::Migration
  def up
    create_table :responders do |t|
      t.string :type
      t.string :name
      t.integer :capacity
      t.boolean :on_duty, default: false
      t.integer :emergency_id
      t.timestamps null: false
    end

    add_index :responders, [:emergency_id], name: :index_responders_on_emergency_id
  end

  def down
    drop_table :responders
  end
end
