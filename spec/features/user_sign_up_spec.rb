feature 'first time user can register' do
  scenario 'user enters registration details and recieves confirmation' do
    expect{ complete_user_sign_up }.to change { User.count }.by 1
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome email123@example.com'
    expect(User.first.email_address).to eq('email123@example.com')
  end
end

feature 'user input detail verifcation' do
  scenario 'user password verifcation does not match' do
    expect{ user_sign_up_non_matching_passwords }.not_to change { User.count }
    expect(page).to have_selector("input[value='email123@example.com']")
    expect(page).to have_content "Password does not match the confirmation"
    expect(current_path).to eq '/users/new'
  end
  scenario 'user provides a blank email address' do
    expect{ user_sign_up_no_email }.not_to change { User.count }
    expect(current_path).to eq '/users/new'
  end
  scenario 'user cannot sign up with a already registered email' do
    complete_user_sign_up
    expect{ complete_user_sign_up }.not_to change { User.count }
    expect(page).to have_content "Email address is already taken"
  end
  scenario 'displays multiple messages - user enters email already taken, and password does not match' do
    complete_user_sign_up
    expect{ user_sign_up_non_matching_passwords }.not_to change { User.count }
    expect(page).to have_content "Email address is already taken"
    expect(page).to have_content "Password does not match the confirmation"
  end
end
