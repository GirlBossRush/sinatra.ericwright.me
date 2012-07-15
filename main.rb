require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/simple-navigation'

require './config/scheduler'

require 'slim'
require 'sass'
require 'compass'

require 'pry' if development?

 Slim::Engine.set_default_options pretty: true, disable_escape: true

def title_helper(prefix = '')
  if !prefix.empty?
    "#{prefix} : Eric Wright : Designer + Developer"
  else
    "Eric Wright : Designer + Developer"
  end
end


configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'assets/sass'
  end

  set :sass, Compass.sass_engine_options
end


get '/stylesheets/*.css' do
  stylesheet = params[:splat].first.to_sym
  sass stylesheet, :views => "#{settings.root}/assets/sass"
end

  
get '/' do
  slim :index, :locals => { title: title_helper("who is") }
end

get '/portfolio' do
  slim :portfolio, :locals => { title: title_helper("portfolio") }
end

get '/contact' do
  slim :contact, :locals => { title: title_helper("let's chat") }
end

get '/resume' do
  send_file('eric_wright_resume.pdf')
end


helpers do
  def link_to(text, url, opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value.to_s << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def mail_to(email, text=email, opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value.to_s << "\" "}
    "<a href=\"mailto:#{email}\" #{attributes}>#{text}</a>"
  end
end