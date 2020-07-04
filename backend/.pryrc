begin
  require "spirit_hands"
  SpiritHands.awesome_print = false
  SpiritHands.coolline = false
rescue LoadError => e
  raise unless /.*such file.*spirit_hands/.match?(e.message)
  puts "no SpiritHands"
end
