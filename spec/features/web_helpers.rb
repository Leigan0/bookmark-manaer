def complete_user_sign_up
  visit '/users/new'
  fill_in 'email_address', with: 'email123@example.com'
  fill_in 'password', with: 'password123'
  fill_in 'password_confirmation', with: 'password123'
  click_button 'sign-up'
end

def user_sign_up_non_matching_passwords
  visit '/users/new'
  fill_in 'email_address', with: 'email123@example.com'
  fill_in 'password', with: 'password123'
  fill_in 'password_confirmation', with: 'password456'
  click_button 'sign-up'
end
