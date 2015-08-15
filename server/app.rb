require 'cuba'
require 'json'
require_relative 'hand_shake'
require_relative 'yaguabot'

Cuba.define do
  on "embaepa" do
    run HandShake
  end

  on "status" do
    run Yaguabot
  end
end