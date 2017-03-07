class Estanterium < ApplicationRecord
  belongs_to :user
  has_many :pelicula
end
