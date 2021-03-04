require "application_system_test_case"

class VotesTest < ApplicationSystemTestCase
  setup do
    @vote = votes(:one)
  end

  test "visiting the index" do
    visit votes_url
    assert_selector "h1", text: "Votes"
  end

  test "creating a Vote" do
    visit votes_url
    click_on "New Vote"

    fill_in "Active to", with: @vote.active_to
    fill_in "Body", with: @vote.body
    fill_in "Current iter", with: @vote.current_iter
    fill_in "Iter array", with: @vote.iter_array
    fill_in "Title", with: @vote.title
    fill_in "Type", with: @vote.type
    fill_in "User", with: @vote.user_id
    click_on "Create Vote"

    assert_text "Vote was successfully created"
    click_on "Back"
  end

  test "updating a Vote" do
    visit votes_url
    click_on "Edit", match: :first

    fill_in "Active to", with: @vote.active_to
    fill_in "Body", with: @vote.body
    fill_in "Current iter", with: @vote.current_iter
    fill_in "Iter array", with: @vote.iter_array
    fill_in "Title", with: @vote.title
    fill_in "Type", with: @vote.type
    fill_in "User", with: @vote.user_id
    click_on "Update Vote"

    assert_text "Vote was successfully updated"
    click_on "Back"
  end

  test "destroying a Vote" do
    visit votes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vote was successfully destroyed"
  end
end
