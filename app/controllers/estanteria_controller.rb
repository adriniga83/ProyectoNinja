class EstanteriaController < ApplicationController

  before_action :authenticate_user!
  
  def index
    
    @generos = ["Acción", "Animación", "Aventura", "Ciencia ficción", "Comedia", "Crimen", "Drama", "Documental", "Familia", "Fantasía", "Guerra", "Historia", "Misterio", "Música", "Romance", "Suspense", "Terror"]
    @medios = ["Todo", "DVD", "Blu-ray", "HD-DVD"]
    @letras = ["#","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @filtrado = {"Medios" => @medios, "Géneros" => @generos}
    
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
    @flag_disco = params[:flag_disco]
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

      #redirect_to search_path(:busqueda => params[:busqueda])

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
      @serie.prestado = 0

      @serie.save

      @estanteria = Estanterium.new
      @estanteria.id_serie = @serie.id_serie
      @estanteria.medio = @serie.soporte
      @estanteria.user_id = current_user.id

      @estanteria.save
      
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
    @flag_disco = params[:flag_disco]
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
  end
  
  def actualizar
    
    @flag_pelicula = params[:flag_pelicula]
    @flag_serie = params[:flag_serie]
    @flag_disco = params[:flag_disco]
    @flag_juego = params[:flag_juego]
    
    if @flag_pelicula == "true"
    
      @edit = params[:edit]
      @prestar = params[:prestar]

      if @edit == "true"
        @pelicula = Pelicula.where(params[:id])
        @pelicula.each do |pelicula|
          if pelicula.id_user == current_user.id && pelicula.id_pelicula.to_s == params[:id]
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

      if @edit == "true"
        @serie = Serie.where(params[:id])
        @serie.each do |serie|
          if serie.id_user == current_user.id && serie.id_serie.to_s == params[:id]
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
      
    end
    
 end
  
end
