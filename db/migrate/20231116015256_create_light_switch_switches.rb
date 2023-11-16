class CreateLightSwitchSwitches < ActiveRecord::Migration[7.1]
  def change
    create_table :light_switch_switches do |t|
      t.string :name, null: false
      t.string :state, null: false, default: "on"

      t.timestamps
    end
    add_index :light_switch_switches, :name, unique: true
  end
end
