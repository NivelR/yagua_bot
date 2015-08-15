require 'cuba'
require 'json'
require_relative 'hand_shake'
require_relative 'yaguabot'


Dir['./lib/**/*.rb'].sort.each          { |rb| require rb }


Cuba.define do
  on "embaepa" do
    run HandShake
  end

  on "status" do
    run Yaguabot
  end
end