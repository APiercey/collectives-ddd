# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require_relative './operations/collectives/index.rb'
require_relative './operations/collectives/show.rb'
require_relative './operations/assets/index.rb'
require_relative './operations/assets/show.rb'
require './lib/infrastructure/exceptions.rb'

module Web
  class Server < Sinatra::Base
    attr_reader :application

    set :show_exceptions, false

    def initialize(application)
      super
      @application = application
    end

    get '/assets' do
      json Web::Operations::Assets::Index
        .new(application)
        .call
    end

    get '/collectives/:id/assets' do
      json Web::Operations::Assets::Show
        .new(application)
        .call(params)
    end

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

    error Exceptions::InternalError do
      status 422

      body = {
        code: 422,
        message: 'Sorry - your request cannot be processed at the moment'
      }

      json body
    end
  end
end
