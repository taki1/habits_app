require 'spec_helper'

describe "StaticPages" do
=begin 
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_index_path
      response.status.should be(200)
    end
  end
=end

  describe "Home page" do

    it "should have the h1 'Home'" do
      visit root_path
      expect(page).to have_content('Home')
    end

    it "should have the base title" do
      visit root_path
      expect(page).to have_title("Demo App")
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title('Home')
    end
  end

  describe "Help page" do

    it "should have the h1 'help'" do
      visit help_path
      expect(page).to have_content('help')
    end

    it "should have the title 'help'" do
      visit help_path
      expect(page).to have_title("Demo App | help")
    end
  end

  describe "About page" do

    it "should have the h1 'about'" do
      visit about_path
      expect(page).to have_content('about')
    end

    it "should have the title 'about'" do
      visit about_path
      expect(page).to have_title("Demo App | about")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("Demo App | Contact")
    end
  end

end
