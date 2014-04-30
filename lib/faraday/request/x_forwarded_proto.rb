module Faraday
  class Request::XForwardedProto < Faraday::Middleware
    def call(env)
      if x_forwarded_proto = ENV['FARADAY_X_FORWARDED_PROTO']
        env[:request_headers]['X-Forwarded-Proto'] = x_forwarded_proto
      end

      @app.call(env)
    end
  end
end

Faraday::Request.register_middleware(x_forwarded_proto: -> { Faraday::Request::XForwardedProto })
