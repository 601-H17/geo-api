# Given /^Utilisateur connecté$/ do
#   @admin = Admin.create(email: "admin@admin.com", password: "admin", username: "admin")
#   visit login_path
#   fill_in("logins_email", :with => @admin.email)
#   fill_in("logins_password", :with => @admin.password)
#   click_button("Connexion")
# end
#
# When(/^Dans le formulaire de téléversement$/) do
#   visit new_upload_path
# end
#
# Then(/^Une carte est téléverser$/) do
#   expect(page).to have_content("Téléverser une carte")
# end