require 'rack/request'
require 'erb'

module RHP
  # Stateless server
  class Server
    attr_reader :root

    def initialize(root)
      @root = root
    end

    def call(env)
      Handler.new(root, env).call
    end

    # Stateful request handler
    class Handler
      attr_reader :root, :env, :status, :headers, :request

      def initialize(root, env)
        @root    = root
        @env     = env
        @status  = 200
        @headers = { 'Content-Type' => 'text/html' }
        @request = Rack::Request.new(env)
      end

      def call
        template = template_path

        if template
          body = ERB.new(File.read(template)).result(binding)
          [ @status, @headers, [ body ] ]
        else
          [ 404, {}, [ "Could not find template for #{request.path}" ] ]
        end
      end

      # Matching template path for the request or nil
      # @return [String,nil]
      def template_path
        exact_path = File.join(root, request.path)
        with_erb = File.join(root, "#{request.path}.html.erb")
        with_index = File.join(root, File.dirname(request.path), 'index.html.erb')

        [ exact_path, with_erb, with_index ].find { |f| File.file?(f) }
      end

      #
      # Methods that imitate PHP functions
      #

      # Gets or sets the response code
      def http_response_code(status = nil)
        if status
          @status = status
        else
          @status
        end
      end

      # Sets headers
      # TODO: special handling like php's #header ?
      def header(string, replace=true, http_response_code=nil)
        name, value = string.split(': ', 2)
        headers[name] = value
      end

      def nl2br(string)
        string.split("\n").join('<br />')
      end
    end
  end
end