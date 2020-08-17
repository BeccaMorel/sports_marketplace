User.destroy_all
Equipment.destroy_all
Booking.destroy_all

rebecca = User.new({ email: "rebecca@email.com", first_name: "Rebecca", last_name: "Morel", password: 123123 })
alex = User.new({ email: "alex@email.com", first_name: "Alex", last_name: "Encinas", password: 123123 })

rebecca.save!
alex.save!

equipment1 = Equipment.new({ name: "blabla", description: "Me gusta", price: 30, booked: false, user_id: rebecca.id })
equipment2 = Equipment.new({ name: "blibli", description: "Me gusta mucho", price: 40, booked: false, user_id: alex.id })

equipment1.save!
equipment2.save!

book1 = Booking.new({ date: "2020.02.12", status: "pending", equipment_id: 2, user_id: 1 })
book1.save!