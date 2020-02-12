require_relative('../db/sql_runner')

class City

  attr_accessor :name, :visited
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @country_id = options['country_id'].to_i
    @visited = "F"
  end

  def save()
    sql = "INSERT INTO cities
    (
      name,
      country_id,
      visited
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @country_id, @visited]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def country()
    country = Country.find(@country_id)
    return country
  end

  def self.countries()
    return Country.all()
  end

  def update()
    sql = "UPDATE cities
    SET
    (
      name,
      country_id
      visited
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@name, @country_id, @visited, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM cities
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def format_name
    return "#{@name.capitalize} #{@name.capitalize}"
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
    return city_data.map { |city| City.new(city) }
  end

  def self.find(id)
    sql = "SELECT * FROM cities
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    city = City.new(result)
    return city

    def self.visited(country_id)
      sql = "SELECT * FROM cities WHERE visited = 't' AND country_id = $1;"
      values = [country_id]
      visited = SqlRunner.run(sql, values)
      return visited.map {|city|City.new(city)}
    end

    def self.not_visited(country_id)
      sql = "SELECT * FROM cities WHERE visited = 'f' AND country_id = $1;"
      values = [country_id]
      visited = SqlRunner.run(sql, values)
      return visited.map {|city|City.new(city)}
    end
  end

end
