class Users::Create < ActiveInteraction::Base
  hash :params do
    array :interests, :skills do
      string
    end

    string :name
    string :surname
    string :patronymic
    string :email
    string :nationality
    string :country
    string :gender
    integer :age
  end

  validate :validate_gender, :validate_age, :check_if_email_in_use

  def execute
    user_full_name = params[:surname].concat(params[:name]).concat(params[:patronymic])
    user_params = params.except(:interests, :skills)
    user = User.create(user_params.merge(full_name: user_full_name))

    interests = Interest.where(name: params[:interests])
    user.interests << interests if interests.present?
    user.update(skills: Skill.where(name: params[:skills])) if params[:skills].present?
  end

  private

  def validate_gender
    errors.add(:gender, "should be male or female") if params[:gender] != "male" && params[:gender] != "female"
  end

  def validate_age
    errors.add(:age, "should be between 0 and 90") if params[:age] <= 0 || params[:age] > 90
  end

  def check_if_email_in_use
    errors.add(:email, "already in use") if User.where(email: params[:email]).exists?
  end
end
