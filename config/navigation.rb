SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
  primary.item :whois, "whois", '/'
  primary.item :work, "work", '/work'
  primary.item :play, "play", "/play"
  primary.item :contact, "contact", '/contact'
  primary.item :github, "github", "https://github.com/ericwright90/"
  end
end