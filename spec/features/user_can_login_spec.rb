require "rails_helper"

RSpec.describe "can log in", :js => :true do
  before(:each) do
    User.create(email: "nate@nate.com", password: "nate", password_confirmation: "nate")
  end
  
  scenario "user can log in" do
    visit '/'

    fill_in "email", with: "nate@nate.com"
    fill_in "password", with: "nate"
    click_on "Submit"
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Welcome to URLLOCKBOX !!!!')
  end
  
  scenario "can not log in with invalid credentials" do
    visit '/'

    fill_in "email", with: "bob@nate.com"
    fill_in "password", with: "nate"
    click_on "Submit"
    expect(current_path).to eq(login_path)
    expect(page).to have_text('Your email and/or password is incorrect, please try again')
  end
  
  scenario "user can log out" do
    visit '/'

    fill_in "email", with: "nate@nate.com"
    fill_in "password", with: "nate"
    click_on "Submit"
    expect(current_path).to eq(root_path)
    click_on "Logout"
    expect(current_path).to eq(login_path)
  end
end