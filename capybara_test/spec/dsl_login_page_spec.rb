# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login Tests' do
  include Capybara::DSL
  #let(:login_lnk) {  find(:xpath, '/html/body/div[1]/div[5]/header/div[3]/div[1]/div/div[3]/nav/div/ul/li[6]/a/div/span') }
#
  before(:each) do
  #  @url = 'https://www.saucedemo.com'
    visit @url
  end

  context "Login with username and password, test the ability to add two items to cart " do
    
    
    usernames = ['standard_user']
    password = 'secret_sauce'
    usernames.each do |username|
      it "should be able to login with the username and password" do
        fill_in 'Username', visible: true, with: username
        fill_in 'password', visible: true, with: password
        click_button 'login-button'
        site_header = find(:xpath, '//*[@id="header_container"]/div[2]/span')
        expect(site_header.text).to eql "Products"
        click_button 'add-to-cart-sauce-labs-backpack'
        click_button 'add-to-cart-sauce-labs-bike-light'
        shopping_cart_badge = find(:xpath, "//span[contains(@class, 'shopping_cart_badge') and contains(@data-test, 'shopping-cart-badge') and contains(text(), '2')]")
        expect(shopping_cart_badge).to be_visible
      end
    end
  end


  #meant to fail
  context "Login with error_user username and password" do

    it 'will return an error'

    credentials = [{ username: 'error_user', password: 'secret_sauce' }]
    credentials.each do |user|
      it "should not be able to login with the #{user[:username]} and #{user[:password]}" do
        fill_in 'Username', visible: true, with: user[:username]
        fill_in 'password', visible: true, with: user[:password]
        click_button 'login-button'
        expect(page).to have_selector(:xpath,'/html/body/div[1]/div/div[2]/div[1]/div/div/form/div[3]/h3/text()')
      end
    end
  end


  context "Login with locked_out_user username and password" do

    it 'will return an error'

    credentials = [{ username: 'locked_out_user', password: 'secret_sauce' }]
    credentials.each do |user|
      it "should not be able to login with the #{user[:username]} and #{user[:password]}" do
        fill_in 'Username', visible: true, with: user[:username]
        fill_in 'password', visible: true, with: user[:password]
        click_button 'login-button'
        sleep 2
        error_message = find(:xpath,'//*[@id="login_button_container"]/div/form/div[3]/h3')
        expect(error_message.text).to include "Epic sadface: Sorry, this user has been locked out."
      end
    end
  end
end