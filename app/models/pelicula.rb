class Pelicula < ApplicationRecord
  serialize :genero
  require 'open-uri'
  has_attached_file :poster
  def poster_from_url(url)
    self.poster = URI.parse(url)
  end
end
