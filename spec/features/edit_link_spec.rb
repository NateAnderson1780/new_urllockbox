require "rails_helper"

RSpec.describe "can edit links", :js => :true do
  
  scenario "edit an existing link" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    
    within('#links-list') do
     expect(page).to have_text("Turing")
     expect(page).to have_text("http://turing.io")
     expect(page).to have_text("Read?: false")
    end

   link = Link.last 
   click_link "Edit"
   expect(current_path).to eq(edit_link_path(link))
   
   fill_in "link[title]", :with => "Example"
   fill_in "link[url]", :with => "http://turing.io"
   click_on "Update Link"
   
   expect(current_path).to eq(links_path)
   within('#links-list') do
    expect(page).to have_text("Example")
    expect(page).to have_text("http://turing.io")
    expect(page).to have_text("Read?: false")
   end
  end
  
  scenario "can not edit a link with invalid url" do
    user_logs_in
    fill_in "link-title", :with => "Turing"
    fill_in "link-url", :with => "http://turing.io"
    click_on "Add Link"
    
    within('#links-list') do
     expect(page).to have_text("Turing")
     expect(page).to have_text("http://turing.io")
     expect(page).to have_text("Read?: false")
    end

   link = Link.last 
   click_link "Edit"
   expect(current_path).to eq(edit_link_path(link))
   
   fill_in "link[title]", :with => "Example"
   fill_in "link[url]", :with => "example"
   click_on "Update Link"
   
   expect(current_path).to eq(edit_link_path(link))
   expect(page).to have_text('Url is not a valid URL')
    
  end
  
  
end