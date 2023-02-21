require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector ".letter", count: 10
  end
  # You can fill the form with a random word, click the play button, and get a message that the word is not in the grid.
  # You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word.
  # You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message.
  test "filling in random word tells us word is not in grid" do
    visit new_url
    fill_in "word", with: "hello"
    click_on "submit"

    assert_text "you cant build that"
  end

  test "filling in random consonant tells us not a word" do
    visit new_url
    fill_in "word", with: "a"
    click_on "submit"

    assert_text "not a word"
  end
end
