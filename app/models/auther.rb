class Auther < ApplicationRecord
    has_many :book_authers
    has_many :books, through: :book_authers
end
