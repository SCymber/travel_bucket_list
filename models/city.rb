require_relative('../db/sql_runner')

class City

  attr_accessor :name, :country_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['first_name']
    @country_id = options['country_id'].to_i
  end

  def save()
    sql = "INSERT INTO cities
    (
      name,
      country_id,
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def country()
    country = Country.find(@country_id)
    return country
  end

  def update()
    sql = "UPDATE cities
    SET
    (
      name,
      country_id
    ) =
    (
      $1, $2
    )
    WHERE id = $5"
    values = [@name, @country_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM cities
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM cities"
    SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM cities"
    city_data = SqlRunner.run(sql)
    cities = map_items(city_data)
    return cities
  end

  def self.map_items(city_data)
    return city_data.map { |city| Student.new(city) }
  end

  def self.find(id)
    sql = "SELECT * FROM cities
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    city = Student.new(result)
    return city
  end

  def format_name
    return "#{@name.capitalize} #{@name.capitalize}"
  end


end
