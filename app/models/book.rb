class Book < ApplicationRecord
    belongs_to :publisher
    has_many :book_authers
    has_many :authers, through: :book_authers
    scope :costy, ->  {where("price > ? ", 7000).limit(3)}
    scope :price, -> {find_by(price:10000)}
    scope :written, -> (theme){where("name like  ?", "%#{theme}%")}

    validates :name, presence: true, length:{maximum:25}
    validate do |book|
      if book.name.include?("hoge")
        book.errors[:name] << "hoge is not allowed"
      end
    end
    before_validation do |b|
        b.name = b.name.gsub(/hoge/) do |mached|
            "prehoge #{mached}"
        end
    end

    before_validation :fuge_to_upfuge

    def fuge_to_upfuge
        if self.name == "fuge"
            self.name = "upfuge"
        end
    end

    after_destroy do |a|
        if a.price > 2000
            puts "hogefugehoge#{a.attributes}"
        end
    end

    enum sales_status:{
        ok: 0,
        bad:1
    }
end