require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Customer.delete_all
Film.delete_all
Screening.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Grandpa Simpson', 'funds' => 100})
customer1.save

customer2 = Customer.new({'name' => 'Marge Simpson', 'funds' => 80})
customer2.save

customer3 = Customer.new({'name' => 'Bart Simpson', 'funds' => 60})
customer3.save

customer4 = Customer.new({'name' => 'Lisa Simpson', 'funds' => 40})
customer4.save

customer5 = Customer.new({'name' => 'Maggie Simpson', 'funds' => 20})
customer5.save

film1 = Film.new({'title' => 'Gone With the Wind', 'price' => 10})
film1.save

film2 = Film.new({'title' => 'Mockingjay', 'price' => 10})
film2.save

film3 = Film.new({'title' => 'Lord of the Rings', 'price' => 8})
film3.save

film3.title = 'Fellowship of the Ring'
film3.update

film2.price = 6
film2.update

customer1.name = 'Homer Simpson'
customer1.update
customer2.funds = 66
customer2.update

screening1 = Screening.new({'film_id' => film1.id, 'show_time' => '18:00', 'tickets_available' => 20, 'tickets_sold' => 0})
screening1.save

screening2 = Screening.new({'film_id' => film1.id, 'show_time' => '20:00', 'tickets_available' => 20, 'tickets_sold' => 0})
screening2.save

screening3 = Screening.new({'film_id' => film2.id, 'show_time' => '18:00', 'tickets_available' => 10, 'tickets_sold' => 0})
screening3.save

screening4 = Screening.new({'film_id' => film2.id, 'show_time' => '20:00', 'tickets_available' => 10, 'tickets_sold' => 0})
screening4.save

screening5 = Screening.new({'film_id' => film3.id, 'show_time' => '21:00', 'tickets_available' => 5, 'tickets_sold' => 0})
screening5.save

screening6 = Screening.new({'film_id' => film3.id, 'show_time' => '22:00', 'tickets_available' => 5, 'tickets_sold' => 0})
screening6.save




ticket1 = Ticket.new({'film_id' => film1.id, 'screening_id' => screening1.id, 'customer_id' => customer1.id})
ticket1.save

ticket2 = Ticket.new({'film_id' => film1.id, 'screening_id' => screening1.id, 'customer_id' => customer2.id})
ticket2.save

ticket3 = Ticket.new({'film_id' => film1.id, 'screening_id' => screening1.id, 'customer_id' => customer3.id})
ticket3.save

ticket4 = Ticket.new({'film_id' => film2.id, 'screening_id' => screening3.id, 'customer_id' => customer1.id})
ticket4.save

ticket5 = Ticket.new({'film_id' => film2.id, 'screening_id' => screening4.id, 'customer_id' => customer1.id})
ticket5.save

ticket6 = Ticket.new({'film_id' => film1.id, 'screening_id' => screening2.id, 'customer_id' => customer5.id})
ticket6.save

ticket7 = Ticket.new({'film_id' => film3.id, 'screening_id' => screening5.id, 'customer_id' => customer1.id})
ticket7.save

ticket8 = Ticket.new({'film_id' => film3.id, 'screening_id' => screening6.id, 'customer_id' => customer4.id})
ticket8.save

ticket9 = Ticket.new({'film_id' => film3.id, 'screening_id' => screening6.id, 'customer_id' => customer5.id})
ticket9.save

puts "Before purchase #{customer1.name} has £#{customer1.funds}, there are #{screening1.tickets_available} tickets for #{film1.title} available at a price of £#{film1.price} each"

customer1.buy_ticket(film1, screening1)

puts "After purchase #{customer1.name} has £#{customer1.funds} left and there are #{screening1.tickets_available} tickets for #{film1.title} remaining"

customer2.buy_ticket(film1, screening1)
customer3.buy_ticket(film1, screening2)
customer4.buy_ticket(film1, screening2)
customer5.buy_ticket(film1, screening2)


# screening1.show_time = '19:00'
# screening1.update
# ticket1.customer_id = customer2.id
# ticket1.update

binding.pry
nil
