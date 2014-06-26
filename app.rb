require "sinatra/base"
# require "sinatra/reloader"

class MyApp < Sinatra::Application
  # register Sinatra::Reloader

  def initialize
    super
    @items = ["good steak", "bad steak", "crab"]

  end

  get "/" do
    erb :root
  end

  get "/items" do
    if params[:filter]
      items = @items.select { |item| item.include?(params[:filter])}
    else
      items = @items
    end
      erb :items, :locals => {:items => items}
  end

   get "/items/new" do
    erb :new
  end

  post "/items/new" do
    @items.push(params[:new_item])
    erb :new
  end

  run! if app_file == $0
end