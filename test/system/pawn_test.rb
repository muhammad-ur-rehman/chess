# frozen_string_literal: true

require 'test_helper'

require 'application_system_test_case'

class PawnTest < ApplicationSystemTestCase
  setup do
    @pawn = Pawn.find(201)
  end

  test 'Showing game right' do
    page.set_rack_session(game_id: @pawn.id)

    visit board_path
    assert_selector 'h1', text: 'Pawn Chess Simulator'
    assert_text(/N/)
  end

  test 'Showing pawn_face' do
    page.set_rack_session(game_id: @pawn.id)

    visit board_path

    assert_selector '.pawn-face'
  end

  test 'Submitting MOVE command' do
    page.set_rack_session(game_id: @pawn.id)
    visit board_path

    fill_in 'Enter command to process', with: 'MOVE'

    click_button 'Submit'
  end

  test 'Pawn position changes after MOVE command' do
    @pawn = Pawn.find(200)
    page.set_rack_session(game_id: @pawn.id)

    visit board_path
    assert_selector 'h1', text: 'Pawn Chess Simulator'
    initial_x = @pawn.x
    initial_y = @pawn.y

    fill_in 'Enter command to process', with: 'MOVE'

    click_button 'Submit'

    assert_wait_for_position_change(initial_x, initial_y)

    assert_not_equal initial_x, @pawn.reload.x
  end

  test 'direction changes after LEFT command' do
    page.set_rack_session(game_id: @pawn.id)
    visit board_path

    initial_pawn_face = find('.pawn-face').text

    fill_in 'Enter command to process', with: 'LEFT'

    click_button 'Submit'
    sleep 1
    updated_pawn_face = find('.pawn-face').text
    assert_not_equal initial_pawn_face, updated_pawn_face
  end

  test 'Error shows after wrong command' do
    page.set_rack_session(game_id: @pawn.id)
    visit board_path

    fill_in 'Enter command to process', with: 'RIGHTII'

    click_button 'Submit'

    assert_selector '.flash__error'
  end

  test 'shows notification on command' do
    page.set_rack_session(game_id: @pawn.id)
    visit board_path

    fill_in 'Enter command to process', with: 'LEFT'

    click_button 'Submit'

    assert_selector '.flash__notice'
  end

  test 'Report shown in  notification on command REPORT' do
    page.set_rack_session(game_id: @pawn.id)
    visit board_path

    fill_in 'Enter command to process', with: 'REPORT'

    click_button 'Submit'

    assert_selector '.flash__notice'
  end

  test 'There is no Pawn on new game' do
    page.set_rack_session(game_id: nil)
    visit board_path

    assert_no_selector '.pawn_face'
  end

  test 'There is no Command Allowed before Place' do
    page.set_rack_session(game_id: Time.now.to_i)
    visit board_path

    assert_no_selector '.pawn'
    fill_in 'Enter command to process', with: 'MOVE'

    click_button 'Submit'

    assert_selector '.flash__error'

    sleep 5

    fill_in 'Enter command to process', with: 'PLACE 0,0,NORTH,WHITE'

    click_button 'Submit'

    assert_selector '.pawn'
    assert_no_selector '.flash__error'
    assert_selector '.flash__notice'
  end

  private

    def assert_wait_for_position_change(initial_x, initial_y)
      wait_for_condition do
        @pawn.reload.x != initial_x || @pawn.reload.y != initial_y
      end
    end
end
