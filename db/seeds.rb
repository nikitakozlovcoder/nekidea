# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
user = User.new(mail: "example@gmail.com", password: "qwerty123", birth_date: 20.years.ago, is_admin: true, rating: 228,
 name: "Omari", surname: "Starks", patronymic: "Ivanovich", restore_date: Time.now.getutc).save
Duty.destroy_all
Duty.where(name: "Все", is_general: true).first_or_create
Duty.where(name: "Разработчики").first_or_create