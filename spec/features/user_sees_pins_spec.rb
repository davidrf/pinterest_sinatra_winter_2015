require 'spec_helper'

feature "user sees pins" do
  scenario "see all pins on index" do
    db_connection do |conn|
      sql_query = "INSERT INTO pins (title, description) VALUES ($1, $2)"
      data = ["Moth sailboat", "hovers over water"]
      conn.exec_params(sql_query, data)
    end

    visit "/pins"
    expect(page).to have_content("Moth sailboat")
  end
end
