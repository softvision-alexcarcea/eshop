class Admins::SessionsController < Devise::SessionsController
  skip_authorization_check
  
  def new
    @signin = true
    super
  end
end
