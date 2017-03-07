Given /^Administrateur connecté$/ do
  @admin = Admin.create(email: "admin@admin.com", password: "admin", username: "admin")
  visit login_path
  fill_in("logins_email", :with => @admin.email)
  fill_in("logins_password", :with => @admin.password)
  click_button("Connexion")
end

When(/^Les locaux sur affichés$/) do
  # visit map_path
end

Then(/^Valide la carte$/) do
  # expect(page).to have_content("Choisissez un étage :")
end
