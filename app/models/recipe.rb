class Recipe < ApplicationRecord
  belongs_to :user
  #Necessaire pour associer une photo a une recette (picture download feature)
 has_one_attached :photo
end
