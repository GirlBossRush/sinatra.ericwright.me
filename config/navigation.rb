SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
  primary.item :whois, "Eric Wright", '/'
  primary.item :work, "work", '/work'
  primary.item :play, "play", "/play"
  end
end
