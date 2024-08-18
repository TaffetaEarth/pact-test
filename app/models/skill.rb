class Skill < ApplicationRecord
  # исправить опечатку - переименовать класс Skil в Skill,
  # либо сделать миграцию с rename_table :skills, :skils
  has_and_belongs_to_many :users
end
