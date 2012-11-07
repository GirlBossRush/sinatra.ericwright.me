SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
  primary.item :whois, "whois", '/'
  primary.item :portfolio, "portfolio", '/portfolio'
  primary.item :contact, "contact", '/contact'
  primary.item :blog, "blog", "http://blog.ericwright.me"
  primary.item :github, "github", "https://github.com/ericwright90/"
  end
end