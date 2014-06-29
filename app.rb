require "sinatra/base"
# require "sinatra/reloader"

class MyApp < Sinatra::Application
  # register Sinatra::Reloader

  def initialize
    super
    @items = File.open('/usr/share/dict/words').read.split(" ")
    @items.slice!(400..-399)
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
    redirect "/items"
  end

  get "/items/:id/edit" do
    pass unless params[:id].to_i <= @items.length
    erb :edit, :locals => {:index => params[:id]}
  end

  put "/items/:id/edit" do
    id = params[:id].to_i
    @items[id-1] = params[:edit_item]
    redirect "/items"
  end

  get "/items/*/edit" do
    erb :DNE
  end

  get "/items/:id" do
    pass unless params[:id].to_i <= @items.length
    id = params[:id].to_i
    erb :single, :locals => {:item => @items[id-1], :index => id}
  end

  delete "/items/:id" do
    id = params[:id].to_i
    @items.slice!(id-1)
    redirect "/items"
  end

  get "/items/*" do
    erb :DNE
  end

  run! if app_file == $0
end