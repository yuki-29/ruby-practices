# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative 'game'

describe Game do
  it '合計スコアの計算 1' do
    scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    frames = Game.new(scores)
    expect(frames.total).to eq 139
  end

  it '合計スコアの計算 2' do
    scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    frames = Game.new(scores)
    expect(frames.total).to eq 164
  end

  it '合計スコアの計算 3' do
    scores = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    frames = Game.new(scores)
    expect(frames.total).to eq 107
  end

  it '合計スコアの計算 4' do
    scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    frames = Game.new(scores)
    expect(frames.total).to eq 134
  end

  it '合計スコアの計算 5' do
    scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    frames = Game.new(scores)
    expect(frames.total).to eq 144
  end

  it '合計スコアの計算 6' do
    scores = 'X,X,X,X,X,X,X,X,X,X,X,X'
    frames = Game.new(scores)
    expect(frames.total).to eq 300
  end

  it '合計スコアの計算 7' do
    scores = 'X,X,X,X,X,X,X,X,X,X,X,2'
    frames = Game.new(scores)
    expect(frames.total).to eq 292
  end

  it '合計スコアの計算 8' do
    scores = 'X,0,0,X,0,0,X,0,0,X,0,0,X,0,0'
    frames = Game.new(scores)
    expect(frames.total).to eq 50
  end
end
# rubocop:enable Metrics/BlockLength
