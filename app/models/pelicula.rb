class Pelicula < ApplicationRecord
  serialize :genero
  require 'open-uri'
  has_attached_file :poster
  def poster_from_url(url)
    self.poster = URI.parse(url)
  end
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |pelicula|
        csv << pelicula.attributes.values_at(*column_names)
      end
    end
  end
end
