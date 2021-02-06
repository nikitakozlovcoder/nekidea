class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password

    validates :mail, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :mail, presence: true
    has_and_belongs_to_many :duties
    def uniq_duties
        duties.distinct
    end
end
