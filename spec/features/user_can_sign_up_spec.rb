require "rails_helper"

RSpec.describe "can sign up", :js => :true do
  scenario "guest can sign up for site" do
    visit '/'
    click_link "HERE"
    expect(current_path).to eq(signup_path)
    
    fill_in "user[email]", with: "nate@nate.com"
    fill_in "user[password]", with: "nate"
    fill_in "user[password_confirmation]", with: "nate"
    click_on "Submit"
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Welcome to URLLOCKBOX !!!!')
  end
  
  scenario "guest can not sign up with invalid credentials" do
    visit '/'
    click_link "HERE"
    expect(current_path).to eq(signup_path)
    
    fill_in "user[email]", with: ""
    fill_in "user[password]", with: "nate"
    fill_in "user[password_confirmation]", with: "nate"
    click_on "Submit"
    expect(current_path).to eq(signup_path)
    expect(page).to have_text("Email can't be blank")
  end
end