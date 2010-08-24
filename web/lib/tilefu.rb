require 'erb'
require 'rubygems'
require 'sinatra/base'
require 'rack/utils'

module TileFu
  class App < Sinatra::Base
    helpers do
      def h(s)
        Rack::Utils.escape_html(s)
      end

      def u(s)
        Rack::Utils.escape(s)
      end

      def page_title
        h(@page_title ? "#@page_title | tilefu.com" : 'tilefu.com')
      end

      def require_login!
        raise 'invalid user' unless session[:user_id]
      end
    end

    configure do
      enable :sessions
      enable :inline_templates
      set :public, 'public'
    end

    get '/' do
      @page_title = 'index'
      erb :index
    end

    get '/play' do
      # require_login!
      @page_title = 'play'
      erb :play
    end
  end
end

__END__
@@ layout
<!DOCTYPE html>
<html lang='en-US'>
  <head>
    <title><%= page_title %></title>
    <link rel='stylesheet' type='text/css' href='/css/style.css'/>
    <script type='text/javascript' src='/js/script.js'></script>
  </head>

  <body><%= yield %></body>
</html>

@@ index
hello there

@@ play
<div>
  <canvas id='c' width='600px' height='600px'/>
</div>
<span id='pos'>&nbsp;</span>
