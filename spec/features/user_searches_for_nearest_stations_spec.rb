require 'rails_helper'

RSpec.feature 'User searches for nearest stations' do
  scenario 'they visit the root path' do
    VCR.use_cassette('search') do
      visit '/'
      fill_in :zip, with: 80203
      click_on 'Locate'

      expect(current_path).to eq('/search')
      expect(page).to have_content('Nearest 10 Stations within 6 miles of 80203')

      within('table') do
        expect(page).to_not have_content('BD')
        expect(page).to_not have_content('CNG')
        expect(page).to_not have_content('E85')
        expect(page).to_not have_content('HY')
        expect(page).to_not have_content('LNG')
      end

      within ('table thead') do
        expect(page).to have_content('Name')
        expect(page).to have_content('Address')
        expect(page).to have_content('Fuel Types')
        expect(page).to have_content('Distance (mi.)')
        expect(page).to have_content('Access Times')
      end
    end
  end
end
