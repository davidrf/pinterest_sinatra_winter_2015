require 'spec_helper'

feature "user sees pin details" do
  scenario "see pin details" do
    db_connection do |conn|
      sql_query = "INSERT INTO pins (title, description) VALUES ($1, $2)"
      data = ["Moth sailboat", "hovers over water"]
      conn.exec_params(sql_query, data)
    end

    visit "/pins"
    click_link "Moth sailboat"
    expect(page).to have_content("Moth sailboat")
    expect(page).to have_content("hovers over water")
  end
end
