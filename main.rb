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
  base = "Eric Wright : Developer + Designer"
  base.insert(0, prefix + ' : ') unless prefix.empty?
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
  slim :index, locals: { title: title_helper("who is") }
end

get '/work' do
  slim :work, locals: { title: title_helper("work") }
end

get '/play' do
  slim :play, locals: { title: title_helper("play") }
end

get '/contact' do
  slim :contact, locals: { title: title_helper("let's chat") }
end

get '/resume' do
  send_file('eric_wright_resume.pdf')
end

get '/resume.doc' do
  send_file('eric_wright_resume.doc')
end

helpers do
  def header_links(text, url)
    link_to(text, url, class: "subtle", target: '_blank') + link_to('@', url, class: "right glow")
  end

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