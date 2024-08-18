class CreateJoinTablesForInterestsAndSkills < ActiveRecord::Migration[7.2]
  def change
    create_join_table :interests, :users do |t|
      t.index :interest_id
      t.index :user_id
    end

    create_join_table :skills, :users do |t|
      t.index :skill_id
      t.index :user_id
    end
  end
end
