class AddSkillsToProject < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.string :skills
    end
  end
end
