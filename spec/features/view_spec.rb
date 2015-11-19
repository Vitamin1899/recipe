require 'spec_helper.rb'

feature "Viewing a formula", js: true do
  before do
    Formula.create!(name: 'Baked Potato w/ Cheese',
           instructions: "nuke for 20 minutes")

    Formula.create!(name: 'Baked Brussel Sprouts',
           instructions: 'Slather in oil, and roast on high heat for 20 minutes')
  end
  scenario "view one formula" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    click_on "Baked Brussel Sprouts"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("Slather in oil")

    click_on "Back"

    expect(page).to     have_content("Baked Brussel Sprouts")
    expect(page).to_not have_content("Slather in oil")
  end
end
