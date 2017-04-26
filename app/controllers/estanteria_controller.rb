class EstanteriaController < ApplicationController
  require 'json'
  require 'uri'
  require 'net/http'
  require 'openssl'

  before_action :authenticate_user!
  
  def index
    
    @generos = ["Acción", "Animación", "Aventura", "Ciencia ficción", "Comedia", "Crimen", "Drama", "Documental", "Familia", "Fantasía", "Guerra", "Historia", "Misterio", "Música", "Romance", "Suspense", "Terror"]
    @medios = ["Todo", "DVD", "Blu-ray", "HD-DVD"]
    @letras = ["#","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @filtrado = {"Medios" => @medios, "Géneros" => @generos}
    @plataformas = ["Super Nintendo", "Nintendo 64", "GameCube", "Wii", "Wii U", "Nintendo Switch", "Game Boy", "Game Boy Color", "Game Boy Advance", "Nintendo DS", "Nintendo 3DS", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4", "PlayStation Portable", "PlayStation Vita", "Xbox", "Xbox 360", "Xbox One", "PC", "Genesis"]
    @estilos =['Rock', 'Electronic', 'Pop', 'Folk, World, & Country', 'Jazz', 'Funk / Soul', "Hip Hop", 'Classical', 'Reggae', 'Latin', 'Stage & Screen', 'Blues', 'Non-Music', "Children's", 'Brass & Military']
    @filtro_juego = {"Plataformas" => @plataformas}
    @filtro_musica = {'Generos' => @estilos}
    
    @multimedia = params[:multimedia]
    
    @abc = params[:abc]
    
    @ordenar = params[:select_ordenar]
    @filtrar = params[:select_filtrar]
   
    @aux = Estanterium.all
   
    #@aux.each do |f|
     # if f.user_id == current_user.id
      #  @pelicula = Pelicula.where(:id => f.id_pelicula)
      #end
    #end    
  end
  
  def create    
    
    @flag_pelicula = params[:flag_pelicula]
    @flag_serie = params[:flag_serie]
    @flag_musica = params[:flag_musica]
    @flag_juego = params[:flag_juego]
    
    if @flag_pelicula == "true"    
      
      title = "titulo"+params[:lotengo]
      average = "puntuacion"+params[:lotengo]
      genre = "genero"+params[:lotengo]
      release = "estreno"+params[:lotengo]
      overview = "sipnosis"+params[:lotengo]
      id_movie = "id_pelicula"+params[:lotengo]
      imdb = "id_imdb"+params[:lotengo]
      image = "poster"+params[:lotengo]
      soporte = "soporte"+params[:lotengo]
      num_copias = "num_copias"+params[:lotengo]
      ubicacion = "ubicacion"+params[:lotengo]

      @pelicula = Pelicula.new
      @pelicula.titulo = params[title] 
      @pelicula.puntuacion = params[average]
      @pelicula.genero = params[genre]
      @pelicula.estreno = params[release]
      @pelicula.sipnosis = params[overview]
      @pelicula.id_pelicula = params[id_movie]
      @pelicula.id_imdb = params[imdb]
      @pelicula.imagen_file_name = params[:url]+params[:tam]+params[image]
      @pelicula.id_user = current_user.id
      @pelicula.soporte = params[soporte]
      @pelicula.num_copias = params[num_copias]
      @pelicula.ubicacion = params[ubicacion]
      @pelicula.prestado = 0

      #@pelicula.poster_from_url(params[:poster])

      @pelicula.save

      @estanteria = Estanterium.new
      @estanteria.id_pelicula = @pelicula.id_pelicula
      @estanteria.medio = @pelicula.soporte
      @estanteria.user_id = current_user.id

      @estanteria.save

      #redirect_to search_path
     
      
      redirect_to estanteria_path

      #render plain: params[:sipnosis].inspect
    end
    
    if @flag_serie == "true"

      title = "titulo"+params[:lotengo]
      average = "puntuacion"+params[:lotengo]
      genre = "genero"+params[:lotengo]
      release = "estreno"+params[:lotengo]
      overview = "sipnosis"+params[:lotengo]
      id_serie = "id_serie"+params[:lotengo]
      image = "poster"+params[:lotengo]
      soporte = "soporte"+params[:lotengo]
      num_copias = "num_copias"+params[:lotengo]
      ubicacion = "ubicacion"+params[:lotengo]
      num_seasons = "season"+params[:lotengo]
      status = "estatus"+params[:lotengo]
      
      arrayTemp = Array.new
      
      (1..params[num_seasons].to_i).each do |i|
        temps = "checkbox"+i.to_s
        if params[temps] != nil
          arrayTemp << i
        end
      end

      @serie = Serie.new
      @serie.titulo = params[title] 
      @serie.puntuacion = params[average]
      @serie.genero = params[genre]
      @serie.estreno = params[release]
      @serie.sipnosis = params[overview]
      @serie.id_serie = params[id_serie]
      @serie.imagen_file_name = params[:url]+params[:tam]+params[image]
      @serie.id_user = current_user.id
      @serie.soporte = params[soporte]
      @serie.num_copias = params[num_copias]
      @serie.ubicacion = params[ubicacion]
      @serie.num_seasons = params[num_seasons]
      @serie.status = params[status]
      @serie.prestado = 0
      @serie.temporadas = arrayTemp

      @serie.save

      @estanteria = Estanterium.new
      @estanteria.id_serie = @serie.id_serie
      @estanteria.medio = @serie.soporte
      @estanteria.user_id = current_user.id

      @estanteria.save
      
      redirect_to estanteria_path
      
    end
    
    if @flag_juego == "true"    
      
      title = "titulo"+params[:lotengo]
      plataform = "plataforma"+params[:lotengo]
      release = "estreno"+params[:lotengo]
      overview = "sipnosis"+params[:lotengo]
      id_game = "id_juego"+params[:lotengo]
      image = "poster"+params[:lotengo]
      soporte = "soporte"+params[:lotengo]
      num_copias = "num_copias"+params[:lotengo]
      ubicacion = "ubicacion"+params[:lotengo]

      @juego = Juego.new
      @juego.titulo = params[title] 
      @juego.plataformas = params[plataform]
      @juego.estreno = params[release]
      @juego.sipnosis = params[overview]
      @juego.id_juego = params[id_game]
      @juego.imagen_file_name = params[image]
      @juego.id_user = current_user.id
      @juego.soporte = params[soporte]
      @juego.num_copias = params[num_copias]
      @juego.ubicacion = params[ubicacion]
      @juego.prestado = 0

      #@pelicula.poster_from_url(params[:poster])

      @juego.save

      @estanteria = Estanterium.new
      @estanteria.id_videojuego = @juego.id_juego
      @estanteria.medio = @juego.soporte
      @estanteria.user_id = current_user.id

      @estanteria.save

      #redirect_to search_path     
      
      redirect_to estanteria_path

      #render plain: params[:sipnosis].inspect
    end  
    
    if @flag_musica == "true"   

      canciones = "canciones"+params[:lotengo]

      resource_url = URI(params[canciones])
      http = Net::HTTP.new(resource_url.host, resource_url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(resource_url)
      response = http.request(request)
      bodyjson = JSON.parse(response.body)
      @tracklist = bodyjson["tracklist"]
      @lista_canciones = Array.new
      
      @tracklist.each do |list|
        @hash = {"Duracion" => list['duration'], "Posicion" => list["position"], "Titulo" => list["title"]}
        @lista_canciones.push(@hash)
      end
      
      title = "titulo"+params[:lotengo]
      genre = "genero"+params[:lotengo]
      release = "estreno"+params[:lotengo]
      soporte = "soporte"+params[:lotengo]
      list = @lista_canciones
      id_music = "id_musica"+params[:lotengo]
      image = "poster"+params[:lotengo]
      num_copias = "num_copias"+params[:lotengo]
      ubicacion = "ubicacion"+params[:lotengo]

      @musica = Musica.new
      @musica.titulo = params[title] 
      @musica.genero = params[genre]
      @musica.estreno = params[release]
      @musica.soporte = params[soporte]
      @musica.lista_canciones = @lista_canciones
      @musica.id_musica = params[id_music]
      @musica.imagen_file_name = params[image]
      @musica.id_user = current_user.id
      @musica.num_copias = params[num_copias]
      @musica.ubicacion = params[ubicacion]
      @musica.prestado = 0

      #@pelicula.poster_from_url(params[:poster])

      @musica.save

      @estanteria = Estanterium.new
      @estanteria.id_musica = @musica.id_musica
      @estanteria.user_id = current_user.id

      @estanteria.save

      #redirect_to search_path     
      
      redirect_to estanteria_path

      #render plain: params[:sipnosis].inspect
    end
    
  end
  
  def destroy
    #id_movie = "id_pelicula"+params[:nolotengo]
    #@delete = Pelicula.where(params[:id])
    #@eliminate = Estanterium.where(params[:id])
    #@delete.each do |borrar|
    #  if borrar.id_user == current_user.id && borrar.id_pelicula.to_s == params[:id]
    #    borrar.destroy
    #  end
    #end
    #@eliminate.each do |borrar1|
    #  if borrar1.user_id == current_user.id && borrar1.id_pelicula == params[:id]
    #    borrar1.destroy
    #  end
    #end
    #redirect_to estanteria_path
  end
  
  def borrar
    
    @flag_pelicula = params[:flag_pelicula]
    @flag_serie = params[:flag_serie]
    @flag_musica = params[:flag_musica]
    @flag_juego = params[:flag_juego]
    
    if @flag_pelicula == "true"
    
    id_movie = "id_pelicula"+params[:lotengo]
    soporte = "soporte"+params[:lotengo]
    
    @delete = Pelicula.where(["soporte = :soporte and id_pelicula = :id", { id: params[id_movie], soporte: params[soporte] }])
    @eliminate = Estanterium.where(["medio = :medio and id_pelicula = :id", { id: params[id_movie], medio: params[soporte] }])
    @delete.each do |borrar|
      if borrar.id_user == current_user.id && borrar.id_pelicula.to_s == params[id_movie]
        borrar.destroy
      end
    end
    @eliminate.each do |borrar1|
      if borrar1.user_id == current_user.id && borrar1.id_pelicula == params[id_movie]
        borrar1.destroy
      end
    end
    redirect_to estanteria_path
    
    end
    
    if @flag_serie == "true"
      
      id_serie = "id_serie"+params[:lotengo]
      soporte = "soporte"+params[:lotengo]

      @delete = Serie.where(["soporte = :soporte and id_serie = :id", { id: params[id_serie], soporte: params[soporte] }])
      @eliminate = Estanterium.where(["medio = :medio and id_serie = :id", { id: params[id_serie], medio: params[soporte] }])
      @delete.each do |borrar|
        if borrar.id_user == current_user.id && borrar.id_serie.to_s == params[id_serie]
          borrar.destroy
        end
      end
      @eliminate.each do |borrar1|
        if borrar1.user_id == current_user.id && borrar1.id_serie == params[id_serie]
          borrar1.destroy
        end
      end
      redirect_to estanteria_path
      
    end
    
    if @flag_juego == "true"
    
    id_game = "id_juego"+params[:lotengo]
    soporte = "soporte"+params[:lotengo]
    
    @delete = Juego.where(["soporte = :soporte and id_juego = :id", { id: params[id_game], soporte: params[soporte] }])
    @eliminate = Estanterium.where(["medio = :medio and id_videojuego = :id", { id: params[id_game], medio: params[soporte] }])
    @delete.each do |borrar|
      if borrar.id_user == current_user.id && borrar.id_juego.to_s == params[id_game]
        borrar.destroy
      end
    end
    @eliminate.each do |borrar1|
      if borrar1.user_id == current_user.id && borrar1.id_videojuego == params[id_game]
        borrar1.destroy
      end
    end
    redirect_to estanteria_path
    
    end   
    
    if @flag_musica == "true"
    
    id_musica = "id_musica"+params[:lotengo]

    @delete = Musica.where(["id_musica = :id", { id: params[id_musica] }])
    @eliminate = Estanterium.where(["id_musica = :id", { id: params[id_musica] }])
    @delete.each do |borrar|
      if borrar.id_user == current_user.id && borrar.id_musica.to_s == params[id_musica]
        borrar.destroy
      end
    end
    @eliminate.each do |borrar1|
      if borrar1.user_id == current_user.id && borrar1.id_musica == params[id_musica]
        borrar1.destroy
      end
    end
    redirect_to estanteria_path
    
    end   
  end
  
  def actualizar
    
    @flag_pelicula = params[:flag_pelicula]
    @flag_serie = params[:flag_serie]
    @flag_musica = params[:flag_musica]
    @flag_juego = params[:flag_juego]
    
    if @flag_pelicula == "true"
    
      @edit = params[:edit]
      @prestar = params[:prestar]

      if @edit == "true"
        @pelicula = Pelicula.where(params[:id])
        @pelicula.each do |pelicula|
          if pelicula.id_user == current_user.id && pelicula.id_pelicula.to_s == params[:id] && pelicula.soporte == params[:soporte]
           pelicula.num_copias = params[:num_copias]
           pelicula.ubicacion = params[:ubicacion]
           pelicula.save
          end
        end
      end

      if @prestar == "true"
        @p = params[:id_prestar]
        @pelicula = Pelicula.where(params[:id])
        @pelicula.each do |pelicula|
          if pelicula.id_user == current_user.id && pelicula.id_pelicula.to_s == params[:id] && pelicula.soporte == params[:soporte]
            if @p == "Si"
              pelicula.prestado = 1
              pelicula.pres_prestamo = params[:pres_prestamo]
              pelicula.save
            end
            if @p == "No"
              pelicula.prestado = 0
              pelicula.pres_prestamo = nil
              pelicula.save
            end
          end
        end
      end
      
    end
    
    if @flag_serie == "true"      
      
      @edit = params[:edit]
      @prestar = params[:prestar]
      @mod_temp = params[:mod_temp]
      
      arrayTemp = Array.new
      
      if @edit == "true"
        @serie = Serie.where(params[:id])
        @serie.each do |serie|
          if serie.id_user == current_user.id && serie.id_serie.to_s == params[:id] && serie.soporte == params[:soporte]
            serie.num_copias = params[:num_copias]
            serie.ubicacion = params[:ubicacion]
            serie.save
          end
        end
      end

      if @prestar == "true"
        @p = params[:id_prestar]
        @serie = Serie.where(params[:id])
        @serie.each do |serie|
          if serie.id_user == current_user.id && serie.id_serie.to_s == params[:id] && serie.soporte == params[:soporte] 
            if @p == "Si"
              serie.prestado = 1
              serie.pres_prestamo = params[:pres_prestamo]
              serie.save
            end
            if @p == "No"
              serie.prestado = 0
              serie.pres_prestamo = nil
              serie.save
            end
          end
        end
      end
      
      if @mod_temp == "true"
        @serie = Serie.where(params[:id])
        @serie.each do |serie|
          if serie.id_user == current_user.id && serie.id_serie.to_s == params[:id] && serie.soporte == params[:soporte]
            (1..params[:num_seasons].to_i).each do |i|
              temps = "checkbox"+i.to_s
              if params[temps] != nil
                arrayTemp << i
              end
            end
            serie.temporadas = arrayTemp
            serie.save
          end
        end
      end
      
    end
    
    if @flag_juego == "true"
    
      @edit = params[:edit]
      @prestar = params[:prestar]

      if @edit == "true"
        @juego = Juego.where(params[:id])
        @juego.each do |juego|
          if juego.id_user == current_user.id && juego.id_juego.to_s == params[:id] && juego.soporte == params[:soporte]
           juego.num_copias = params[:num_copias]
           juego.ubicacion = params[:ubicacion]
           juego.save
          end
        end
      end

      if @prestar == "true"
        @p = params[:id_prestar]
        @juego = Juego.where(params[:id])
        @juego.each do |juego|
          if juego.id_user == current_user.id && juego.id_juego.to_s == params[:id] && juego.soporte == params[:soporte]
            if @p == "Si"
              juego.prestado = 1
              juego.pres_prestamo = params[:pres_prestamo]
              juego.save
            end
            if @p == "No"
              juego.prestado = 0
              juego.pres_prestamo = nil
              juego.save
            end
          end
        end
      end
      
    end
    
    if @flag_musica == "true"
    
      @edit = params[:edit]
      @prestar = params[:prestar]

      if @edit == "true"
        @musica = Musica.where(params[:id])
        @musica.each do |musica|
          if musica.id_user == current_user.id && musica.id_musica.to_s == params[:id]
           musica.num_copias = params[:num_copias]
           musica.ubicacion = params[:ubicacion]
           musica.save
          end
        end
      end

      if @prestar == "true"
        @p = params[:id_prestar]
        @musica = Musica.where(params[:id])
        @musica.each do |musica|
          if musica.id_user == current_user.id && musica.id_musica.to_s == params[:id]
            if @p == "Si"
              musica.prestado = 1
              musica.pres_prestamo = params[:pres_prestamo]
              musica.save
            end
            if @p == "No"
              musica.prestado = 0
              musica.pres_prestamo = nil
              musica.save
            end
          end
        end
      end
      
    end
    
 end
  
end
