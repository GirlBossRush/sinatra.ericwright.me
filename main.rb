require 'sinatra'
require 'sinatra/contrib/all'
require 'sinatra/simple-navigation'

require './config/scheduler'

require 'slim'
require 'redcarpet'
require 'sass'
require 'compass'

require 'pry' if development?

 Slim::Engine.set_default_options pretty: true, disable_escape: true

def title_helper(prefix = '')
  base = "Eric Wright : Developer + Designer"
  base.insert(0, prefix + ' - ') unless prefix.empty?
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
  slim :index, locals: { title: title_helper("1.44 MB of fun"), klass: 'index' }
end

get '/work' do
  slim :work, locals: { title: title_helper("Work"), klass: 'work' }
end

get '/resume' do
  send_file('resume/eric_wright_resume.pdf')
end

helpers do
  def header_links(text, url)
    link_to(text, url, class: "subtle", target: '_blank')
  end

  def link_to(text, url, opts={target: '_blank'})
    attributes = ""
    opts.each { |key, value| attributes << key.to_s << "=\"" << value.to_s << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def mail_to(email, text=email, opts={})
    attributes = "?"
    opts.each do |key, value|
      attributes << key.to_s << "=" << value.to_s << "\""
    end
    attributes.gsub!(" ", "%20")
    return "<a href=\"mailto:#{email}#{attributes} target='_blank'\>#{text}</a>"
  end
end
