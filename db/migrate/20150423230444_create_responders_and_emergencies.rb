class CreateRespondersAndEmergencies < ActiveRecord::Migration
  def up
    create_table :emergencies, force: :cascade do |t|
      t.string   :code
      t.integer  :fire_severity
      t.integer  :police_severity
      t.integer  :medical_severity
      t.datetime :resolved_at
      t.boolean  :full_response,    default: true
      t.timestamps null: false
    end

    create_table :responders, force: :cascade do |t|
      t.string   :type
      t.string   :name
      t.integer  :capacity
      t.boolean  :on_duty,      default: false
      t.integer  :emergency_id
      t.timestamps null: false
    end

    add_index :responders, [:emergency_id], name: :index_responders_on_emergency_id
  end

  def down
    drop_table :emergenceis
    drop_table :responders
  end
end
