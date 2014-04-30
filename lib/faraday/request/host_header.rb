module Faraday
  class Request::HostHeader < Faraday::Middleware
    def call(env)
      if host_header = ENV['FARADAY_HOST']
        env[:request_headers]['Host'] = host_header
      end

      @app.call(env)
    end
  end
end

Faraday::Request.register_middleware(host_header: -> { Faraday::Request::HostHeader })
