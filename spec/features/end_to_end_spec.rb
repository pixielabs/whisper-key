require 'spec_helper'

describe "EndToEnd", js: true do
  it "works!" do
    Capybara.default_wait_time = 20
    Capybara.session_name = "receiver"
    visit root_path
    click_link "Receive a secure message"

    expect(page).to have_text("Your magic words are")
    magic_words = page.all(".magic-word").map{|w| w.text}.join(" ")

    Capybara.session_name = "sender"
    visit root_path
    click_link "Send a secure message"
    fill_in("magic words", with: magic_words)
    click_button "Submit"

    message = "Test"

    fill_in("message", with: message)
    click_button "Encrypt this message"
    click_button "Send encrypted message"

    Capybara.session_name = "receiver"
    visit root_path
    click_link "Receive a secure message"
    click_link "Continue with these magic words"
    page.find(".list-group-item").click

    click_button "Decrypt with your private key"

    expect(page).to have_css("#decrypted")
    expect(page.find("#decrypted").text).to eq(message)
  end
end
