# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require_relative './operations/collectives/index.rb'
require_relative './operations/collectives/show.rb'
require_relative './application.rb'

application = Application.new

get '/collectives/:id' do
  json Web::Operations::Collectives::Show
    .new(application)
    .call(params)
end

get '/collectives' do
  json Web::Operations::Collectives::Index
    .new(application)
    .call
end

get '/' do
  'Hello world'
end
