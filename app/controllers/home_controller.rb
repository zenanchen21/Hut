class UsersController < ApplicationController
  def autocomplete
    users = User.all.map do |user|
      {
        name: user.name
      }
    end

    render json: users
  end
end
