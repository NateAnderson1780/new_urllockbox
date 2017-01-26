require "rails_helper"

RSpec.describe "can mark links as read", :js => :true do
  
  scenario "user can mark links as read" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    expect(current_path).to eq(root_path)
    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: false")
      expect(page).to have_button('Mark as Read')
    end
    click_button "Mark as Read"
    
    expect(current_path).to eq(root_path)
    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: true")
      expect(page).to have_button('Mark Unread')
    end
  end
  
  scenario "user can mark links as unread" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    expect(current_path).to eq(root_path)
    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: false")
      expect(page).to have_button('Mark as Read')
    end
    click_button "Mark as Read"
    
    expect(current_path).to eq(root_path)
    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: true")
      expect(page).to have_button('Mark Unread')
    end
    click_button "Mark Unread"
    
    expect(current_path).to eq(root_path)
    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: false")
      expect(page).to have_button('Mark as Read')
    end
  end
end