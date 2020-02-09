require_relative ('../db/sql_runner')
require('pry')

class City

  attr_reader :id
  attr_accessor :name, :country_id, :visited

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @country_id = details['country_id'].to_i
    @visited = details['visited'] == "t" ? true : false
  end

  def save()
    sql = "INSERT INTO cities (name, country_id, visited) VALUES ($1, $2, $3) RETURNING id;"
    values = [@name, @country_id, @visited]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM cities"
    results = SqlRunner.run(sql)
    return results.map {|city|City.new(city)}
  end

  def update()
    sql = "UPDATE cities SET (name, country_id, visited) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @country_id, @visited, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM cities"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM cities WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM cities WHERE id = $1"
    values = [id]
    city = SqlRunner.run(sql, values).first
    return City.new(city)
  end
end
