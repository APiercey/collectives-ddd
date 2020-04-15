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
    set :strict_paths, false

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

    get '/' do
      <<~HTML
        <html>
          <body>
            <h1>Hi! Welcome to my DDD application named Collectives!</h1>
            <p>This was build to demonstrate effective testing strategies for the patterns common when employing DDD.</p>
            <p>The routes provided are:</p>

            <ul>
              <li> <strong>/</strong> You are here ;)</li>
              <li> <strong>/collectives</strong> Provides a collection of OpenCollectives which this application cares about (for testing purpose :]).</li>
              <li> <strong>/collectives/:id</strong> Provides a single OpenCollective based upon the ID (UUID created in this application).</li>
              <li> <strong>/collectives/id:/assets</strong> The assets of the OpenCollective.</li>
              <li> <strong>/assets</strong> The assets of all OpenCollectives which this application cares about.</li>
            </ul>
          </body>
        </html>
      HTML
    end

    get '/favicon.ico' do
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
