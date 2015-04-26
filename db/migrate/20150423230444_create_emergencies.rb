class CreateEmergencies < ActiveRecord::Migration
  def up
    create_table :emergencies do |t|
      t.string :code
      t.integer :fire_severity
      t.integer :police_severity
      t.integer :medical_severity
      t.datetime :resolved_at
      t.boolean :full_response, default: true
      t.timestamps null: false
    end
  end

  def down
    drop_table :emergencies
  end
end
