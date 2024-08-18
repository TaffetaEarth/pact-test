class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :full_name
      t.string :email
      t.string :nationality
      t.string :country
      t.string :gender
      t.integer :age

      t.timestamps
    end
  end
end
