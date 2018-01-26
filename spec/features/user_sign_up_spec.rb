feature 'first time user can register' do
  scenario 'user enters registration details and recieves confirmation' do
    expect{ complete_user_sign_up }.to change { User.count }.by 1
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome email123@example.com'
    expect(User.first.email_address).to eq('email123@example.com')
  end
  scenario 'user password verifcation does not match' do
    expect{ user_sign_up_non_matching_passwords }.not_to change { User.count }
    expect(page).to have_content "Passwords do not match, please try again"
    expect(current_path).to eq '/users/new'
    expect(page).to have_selector("input[value='email123@example.com']")
  end
end
