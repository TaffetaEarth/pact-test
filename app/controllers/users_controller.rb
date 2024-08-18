class UsersController < ApplicationController
  def create
    Users::Create.run!(params: user_params)
  end

  def user_params
    params.require(:user).permit(
      :name, :patronymic, :email, :age,
      :nationality, :country, :gender,
      :surname, interests: [], skills: []
    )
  end
end
