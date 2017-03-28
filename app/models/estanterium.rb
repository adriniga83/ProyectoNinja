class Estanterium < ApplicationRecord
  belongs_to :user
  has_many :pelicula
  has_many :serie
end
