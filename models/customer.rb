require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :funds, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
            (name,
            funds)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def films()
    sql = "SELECT films.* FROM tickets
          INNER JOIN films
          ON tickets.film_id = films.id
          where tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{|film| Film.new(film)}
    return result
  end

  def buy_ticket(film,screening)
    if @funds >= film.price
      if screening.tickets_available > 0

        @funds -= film.price
        screening.tickets_available -= 1
        screening.tickets_sold += 1

        self.update
        screening.update
      else
        puts "No tickets left"
      end
    else
      puts "No money left"
    end
  end

  def tickets
    sql = "SELECT COUNT(*) FROM tickets
          WHERE tickets.customer_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).first['count'].to_i
  end

  def self.delete_all
   sql = "DELETE FROM CUSTOMERS"
   SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end

  def update()
    sql = "UPDATE customers SET(
    name,
    funds
    ) =
    ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

end
