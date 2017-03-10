class SearchController < ApplicationController
  require 'json'
  require 'uri'
  require 'net/http'

  before_action :authenticate_user!
  
  def search
 
    @categoria = params[:id]
    
    if @categoria == "Peliculas"   
      @respuesta = false;
      @busqueda = params[:titulo]
      if request.post?
        @search = Tmdb::Movie.find(params[:titulo]);
      end
      url = URI("https://api.themoviedb.org/3/configuration?api_key=d4345c394b5a85b5749cfb819a8b2e01")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      #request.body = "{}"

      response = http.request(request)
      #@prueba = response.read_body 
      bodyjson = JSON.parse(response.body)
      @base_url = bodyjson['images']['base_url']
      @sizes = bodyjson['images']['poster_sizes']
      @prueba = "PASAAA"
    end
    
    if @categoria == "Discos"
      
     app_key = 'KWqwYwVmtTmeqhdePChA'
     app_secret = 'vKhpoTljtDVzTOvsFhoIExnVWLukuFwI'
     url = URI("https://api.discogs.com/database/search?q="+params[:titulo]+"&key="+app_key+"&secret="+app_secret)

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)

     response = http.request(request)
     bodyjson = JSON.parse(response.body)
     @cancion = bodyjson["results"]
        
    end
    
    if @categoria == "Juegos"
      
      @juego = GiantBomb::Game.find(params[:titulo])
      
    end
    
    if @categoria == "Series"
      
      @serie = Tmdb::TV.find(params[:titulo]);
      
    end
    
  end
  
  def configuracion
    
  end
end
