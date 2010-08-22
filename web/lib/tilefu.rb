require 'erb'
require 'rubygems'
require 'sinatra/base'

module TileFu
  class App < Sinatra::Base
    configure do
      enable :sessions
      enable :inline_templates
      set :public, 'public'
    end

    get '/' do
      erb :hello
    end
  end
end

__END__
@@ layout
<!DOCTYPE html>
<html lang='en-US'>
<body><%= yield %></body>
</html>

@@ hello
hello there
