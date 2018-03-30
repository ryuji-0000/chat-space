module ControllerMacros
  def login(usre)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end
