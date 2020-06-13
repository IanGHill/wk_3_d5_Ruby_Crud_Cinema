require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @title = options['title']
   @price = options['price'].to_i
 end

 def save()
   sql = "INSERT INTO films
            (title,
            price)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
 end

 def which_customers()
   sql = "SELECT customers.* FROM tickets
          INNER JOIN customers
          ON tickets.customer_id = customers.id
          where tickets.film_id = $1"
   values = [@id]
   customers = SqlRunner.run(sql, values)
   result = customers.map{|customer| Customer.new(customer)}
   return result
 end

 def how_many_customers
   sql = "SELECT COUNT(*) FROM tickets
         WHERE tickets.film_id = $1"
   values = [@id]
   return SqlRunner.run(sql, values).first['count'].to_i
 end

 def most_popular_screening_using_sql
   sql = "SELECT * FROM screenings
          WHERE film_id = $1
          ORDER BY tickets_sold DESC"
   values = [@id]
   screenings = SqlRunner.run(sql, values).first

   if screenings['tickets_sold'].to_i > 0
     return screenings['show_time']
   else
     return "No tickets sold for this film"
   end
 end

 def most_popular_screening_using_sort
   sql = "SELECT * FROM screenings
          WHERE film_id = $1"
   values = [@id]
   screenings = SqlRunner.run(sql, values)

   sorted_screenings_asc = screenings.sort_by {|item| item['tickets_sold'].to_i}
   sorted_screenings_desc = sorted_screenings_asc.reverse

   if sorted_screenings_desc[0]['tickets_sold'].to_i > 0
     return sorted_screenings_desc[0]['show_time']
   else
     return "No tickets sold for this film"
   end
 end

 def self.delete_all
   sql = "DELETE FROM films"
   SqlRunner.run(sql)
 end

 def self.all()
   sql = "SELECT * FROM films"
   films = SqlRunner.run(sql)
   result = films.map {|film| Film.new(film)}
   return result
 end

 def update()
   sql = "UPDATE films SET(
   title,
   price
   ) =
   ($1, $2)
   WHERE id = $3"
   values = [@title, @price, @id]
   SqlRunner.run(sql, values)
 end

end
