class AdminsController < ApplicationController
  load_and_authorize_resource

  def new
    @title = "Create admin"
    @new_admin = true
  end

  def create
    if @admin.save
      redirect_to root_path, flash: { success: "Admin successfully created" }
    else
      flash.now[:error] = "Could not create admin"
      render :new
    end
  end
end
