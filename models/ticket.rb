require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :film_id, :screening_id, :customer_id

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @film_id = options['film_id']
   @screening_id = options['screening_id']
   @customer_id = options['customer_id']
 end

 def save()
   sql = "INSERT INTO tickets
            (film_id,
            screening_id,
            customer_id)
            VALUES
            ($1, $2, $3)
            RETURNING id"
    values = [@film_id, @screening_id, @customer_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i

 end

 def self.delete_all
   sql = "DELETE FROM tickets"
   SqlRunner.run(sql)
 end

 def self.all()
   sql = "SELECT * FROM tickets"
   tickets = SqlRunner.run(sql)
   result = tickets.map {|ticket| Ticket.new(ticket)}
   return result
 end

 def update()
   sql = "UPDATE tickets SET(
   film_id,
   screening_id,
   customer_id
   ) =
   ($1, $2, $3)
   WHERE id = $4"
   values = [@film_id, @screening_id, @customer_id, @id]
   SqlRunner.run(sql, values)
 end

end
