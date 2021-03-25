class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password
    has_many :votes, dependent: :nullify
    validates :mail, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :mail, presence: true
    #DONT USE .duties and duties_users METHODS MOTHERFUCKERS!!!!!!!!!!!!!!! ITS PRIVATE. USE writable_duties, add_duty OR all_duties COS ADMINS
    # & BOSSES MAY HAVE ADDITIONAL DUTIES NOT LISTED IN THEIR DB RELATIONS, OR U CAN KILL DB WITH DUPLICATES
    has_many :duties_users, class_name: "DutyUser", dependent: :destroy
    has_many :duties, through: :duties_users, class_name: "Duty"
    private :duties_users, :duties_users=, :duties, :duties=
    def add_duty duty
        if  duties.find_by(id: duty.id)== nil
            duties << duty
        end
    end

    def writable_duties
        arr = []
        self.duties_users.each do |d|
            if d.duty.write_all and d.has_write_access
                arr << d.duty
            end
        end
        arr
    end

    def delete_duty id
        self.duties.delete(id)
    end
    def all_duties
        self.duties
    end

end
