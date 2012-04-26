module RequestMacros
  def login_user
    before(:each) do
      user = FactoryGirl.create(:user)
      department = FactoryGirl.create(:department)

      user.departments = [department]

      get new_user_session_path
      response.should be_success
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_button 'Sign in'
      response.should be_success
    end
  end
end
