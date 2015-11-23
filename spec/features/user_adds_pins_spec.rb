require 'spec_helper'

feature "user adds pins" do
  scenario "successfully adds pin" do
    visit "/pins/new"
    fill_in "Title", with: "Moth sailboat"
    fill_in "Description", with: "hovers over water"
    click_on "Add Pin"

    expect(page).to have_content("Moth sailboat")
  end
end
