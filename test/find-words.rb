#!/usr/bin/env ruby

require 'jiffy'

module TileFu
  LAYOUTS = {
    'default'  => {
      'name'   => 'Default',
      'blurb'  => 'Default board layout.',
      'width'  => 16,
      'height' => 16,
    },
  }

  dicts
    dict_id
    dict_name
    dict_blurb

  dict_words
    word_id
    dict_id
    word

  layouts
    layout_id
    layout_name
    layout_blurb
    width
    height
    start_pos

  layout_bonuses
    layout_id
    x, y
    bonus

  bag_id
    bag_id
    bag_name

  bag_letters
    bag_id
    letter
    count
    score

  styles
    style_id
    style_name
    style_blurb

    bag_id
    layout_id
    num_tries

  style_dicts
    game_id
    dict_id

  games
    game_id
    game_state
    style_id
    bag (string of remaining tiles)
    board (string of board state ' ' = empty, uc = blank)
    turn

  game_users
    game_id
    user_id
    pos
    rack
    score

  game_turns
    turn_id
    game_id
    user_id
    score

  turn_moves
    turn_id
    move_id
    pos
    move_type (good, bad, pass, swap)
    x, y
    tiles
    is_horizontal

  move_good_words
    move_id
    word_id
    score

  move_bad_words
    move_id
    bad_word

  move_swaps
    move_id
    old_tiles
    new_tiles




      Layout
        attr_reader :w, :h, :start_pos, :bonuses, :tiles
      
  class Board
    SPAN = 10

    def initialize(src = nil)
      @w, @h, @tiles = SPAN, []
      load_json(src)
    end

    private

    def load_json(src)
      data = Jiffy.decode(src)

      
