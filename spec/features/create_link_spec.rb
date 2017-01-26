require "rails_helper"

RSpec.describe "can create links", :js => :true do
  before(:each) do
    user_logs_in
  end
  
  scenario "Create a new link" do
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
      expect(page).to have_text("Read?: false")
    end
  end
  
  scenario "can not create link with invalid url" do
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "turing"
    click_on "Add Link"

    within('#links-list') do
      expect(page).not_to have_text("Turing")
      expect(page).not_to have_text("http://turing.io")
      expect(page).not_to have_text("Read?: false")
    end
  end
end
