require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time, :tickets_available, :tickets_sold

 def initialize(options)
   @id = options['id'].to_i if options['id']
   @film_id = options['film_id']
   @show_time = options['show_time']
   @tickets_available = options['tickets_available'].to_i
   @tickets_sold = options['tickets_sold'].to_i
 end

 def save()
   sql = "INSERT INTO screenings
            (film_id,
            show_time,
            tickets_available,
            tickets_sold)
            VALUES
            ($1, $2, $3, $4)
            RETURNING id"
    values = [@film_id, @show_time, @tickets_available, @tickets_sold]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i

 end

 def self.delete_all
   sql = "DELETE FROM screenings"
   SqlRunner.run(sql)
 end

 def self.all()
   sql = "SELECT * FROM screenings"
   screenings = SqlRunner.run(sql)
   result = screenings.map {|screening| Screening.new(screening)}
   return result
 end

 def update()
   sql = "UPDATE screenings SET(
   film_id,
   show_time,
   tickets_available,
   tickets_sold
   ) =
   ($1, $2, $3, $4)
   WHERE id = $5"
   values = [@film_id, @show_time, @tickets_available, @tickets_sold, @id]
   SqlRunner.run(sql, values)
 end

end
