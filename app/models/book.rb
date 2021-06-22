class Book < ApplicationRecord
    validates :title,:body, presence: true
    has_many :favorites, dependent: :destroy
end
