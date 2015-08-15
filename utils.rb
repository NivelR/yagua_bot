module Utils
  module Addresses
    require 'resolv'

    self.valid_ipv4 = Resolv::IPv4::Regex
    self.valid_port = /^port 0*(?:6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{1,3}|[0-9])$/
  end
end