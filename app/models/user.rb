class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password
    has_many :votes, dependent: :nullify
    validates :mail, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :mail, presence: true
    has_many :duties_users, class_name: "DutyUser", dependent: :destroy
    has_many :duties, through: :duties_users, class_name: "Duty"

    def add_duty duty
        if  duties.find_by(id: duty.id)== nil
            duties << duty
        end
    end


end
