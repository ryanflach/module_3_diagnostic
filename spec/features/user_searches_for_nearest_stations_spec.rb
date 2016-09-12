require 'rails_helper'

RSpec.feature 'User searches for nearest stations' do
  context 'with zip code param only' do
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

  context 'with zip code and distance param' do
    xscenario 'they visit the root path' do
      VCR.use_cassette('search_with_distance') do
        # When I visit "/"
        visit '/'
        # And I fill in the search form with 80203
        fill_in :zip, with: 80203
        # And I enter "5" into an optional "Distance" field
        fill_in :distance, with: 5
        # And I click "Locate"
        click_on 'Locate'
        # Then I should see a list of the 10 closest stations of any type within 5 miles sorted by distance
        expect(page).to have_content('Nearest 10 Stations within 5 miles of 80203')
        # And the results should share the same format as above
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
        # And I should see about 6 pagination links at the bottom of the results (As of the writing of this story there are 63 results. Number of links should be RESULTS divided by 10)
        expect(page).to have_link('2')
        expect(page).to have_link('3')
        expect(page).to have_link('4')
        expect(page).to have_link('5')
        expect(page).to have_link('6')
      end
    end
  end
end
