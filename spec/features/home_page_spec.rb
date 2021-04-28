require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  let (:anon_user) { FactoryBot.create(:user) }

  scenario "New user lands on site" do
    2.times { create(:dog, user: anon_user) }

    visit "/"

    expect(page).to have_selector('.dog-photo', count: 2)
    expect(page).to have_selector('.dog-name', count: 2)

    expect(page).to have_text("Sign in")
    expect(page).to have_text("Sign up")
  end
end
