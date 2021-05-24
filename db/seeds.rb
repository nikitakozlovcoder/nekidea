# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Schedule.destroy_all
Schedule.create(checked_at: nil)


d = Duty.where(name: "Все", is_general: true).first_or_create
Duty.where(name: "Разработчики").first_or_create
Duty.where(name: "Тестировщики").first_or_create
Duty.where(name: "Маркетологи").first_or_create
u = User.find_by(mail: "example@gmail.com")
puts "USER!!!!!!!!!!!!!!"
pp u
if (u==nil)
  puts "CREATING"
  user = User.new(mail: "example@gmail.com", password: "qwerty123", birth_date: "12.04.1995", is_admin: false, rating: 228,
                  name: "Omari", surname: "Starks", patronymic: "Ivanovich", restore_date: Time.now.getutc, is_boss: true)

  user.avatar.attach(io: File.open(File.join(File.dirname(__FILE__), '35.jpg')), filename: '35.jpg')
  user.save
  user.add_duty d
else
  u.add_duty d
  u.avatar.purge
  u.avatar.attach(io: File.open(File.join(File.dirname(__FILE__), '35.jpg')), filename: '35.jpg')
end

#Duty.destroy_all



