When(/^Les locaux sur affichés$/) do
  visit map_path
end

Then(/^Valide la carte$/) do
  # Le bouton Validate sera fait dans la user story de téléversement de la carte
  # should have_content("Link Clicked")
end
