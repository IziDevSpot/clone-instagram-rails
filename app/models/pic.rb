class Pic < ApplicationRecord
  acts_as_votable
  
  belongs_to :user
  
  #CHANGED 
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, 
                                      default_url: "http://placehold.it/300x300" #"/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/  
end