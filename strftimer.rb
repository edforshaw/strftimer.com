require 'sinatra'
require 'sinatra/reloader' if development?
require 'date'

require './constants'
Dir.glob('./models/token/concerns/*.rb').each { |file| require file }
Dir.glob('./models/**/*.rb').each { |file| require file }

get '/' do
  erb :index
end

get '/translate' do
  @translator = Translator.new(params[:query])

  if @translator.valid?
    content_type :json
    {
      translation: @translator.translation,
      help: @translator.help_message
    }.to_json
  else
    status 500
  end
end
