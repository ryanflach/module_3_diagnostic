require 'rails_helper'

RSpec.feature 'User searches for nearest stations' do
  scenario 'they visit the root path' do
    VCR.use_cassette('search') do
      # As a user
      # When I visit "/"
      visit '/'
      # And I fill in the search form with 80203
      fill_in :zip, with: 80203
      # And I click "Locate"
      click_on 'Locate'
      # Then I should be on page "/search" with parameters visible in the url
      expect(current_path).to eq('/search')
      # Then I should see a list of the 10 closest stations within 6 miles sorted by distance
      expect(page).to have_content('Nearest 10 Stations within 6 miles of 80203')
      # And the stations should be limited to Electric and Propane
      within('table') do
        expect(page).to_not have_content('BD')
        expect(page).to_not have_content('PLG')
        expect(page).to_not have_content('BD')
      end
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      within ('table thead') do
        expect(page).to have_content('Name')
        expect(page).to have_content('Address')
        expect(page).to have_content('Fuel Types')
        expect(page).to have_content('Distance')
        expect(page).to have_content('Access Times')
      end
    end
  end
end
