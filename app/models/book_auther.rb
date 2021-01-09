class BookAuther < ApplicationRecord
  belongs_to :book
  belongs_to :auther
end
