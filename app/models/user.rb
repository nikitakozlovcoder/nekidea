class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password
    has_many :votes, dependent: :nullify
    has_many :ideas
    validates :mail, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :mail, presence: true
    validate :validate_birth_date
    #DONT USE .duties and duties_users METHODS MOTHERFUCKERS!!!!!!!!!!!!!!! ITS PRIVATE. USE writable_duties, add_duty OR all_duties COS ADMINS
    # & BOSSES MAY HAVE ADDITIONAL DUTIES NOT LISTED IN THEIR DB RELATIONS, OR U CAN KILL DB WITH DUPLICATES
    has_many :duties_users, class_name: "DutyUser", dependent: :destroy
    has_many :duties, through: :duties_users, class_name: "Duty"
    has_many :comments
    private :duties_users, :duties_users=, :duties, :duties=
    attr_accessor :current_password
    validate :current_password_is_correct, on: :update


    def can_write_to_duty? duty
        if self.is_admin
            return true
        elsif self.is_boss
             return (self.duties.find_by(id: duty.id) != nil)
        else
            du = self.duties_users.find_by(duty_id: duty.id)
            return (du.duty.write_all and du.has_write_access)
        end
    end

    def add_duty duty
        if  self.duties.find_by(id: duty.id)== nil
            self.duties << duty
        end
    end

    def writable_duties
        arr = []

        if self.is_admin
            arr = Duty.all.to_a
        elsif self.is_boss
            arr = self.duties.to_a
        else
            self.duties_users.each do |d|
                if d.duty.write_all and d.has_write_access
                    arr << d.duty
                end
            end
        end

        arr
    end

    def delete_duty id
        self.duties.delete(id)
    end

    def all_duties
        if self.is_admin
            Duty.all
        else
            self.duties
        end
    end

    private
    def current_password_is_correct
        # Check if the user tried changing his/her password
        unless password.blank?
            # Get a reference to the user since the "authenticate" method always returns false when calling on itself (for some reason)
            user = User.find(id)

            # Check if the user CANNOT be authenticated with the entered current password
            unless user.authenticate(current_password)
                # Add an error stating that the current password is incorrect
                errors.add(:current_password, "Старый пароль неверный")
            end
        end
    end
    def validate_birth_date
       pp "Validate date!"
       pp birth_date
       pp read_attribute_before_type_cast(:birth_date)
        unless read_attribute_before_type_cast(:birth_date).blank?
            begin
                Date.parse(read_attribute_before_type_cast(:birth_date))
                #Date.parse(read_attribute_before_type_cast(:birth_date))
            rescue
                errors.add(:birth_date, "Неправильный формат даты")
            end
        end

    end

end
