require_relative('../db/sql_runner')

class Country

  attr_reader :id, :name, :visited

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @visited = options['visited']
  end

  def save()
    sql = "INSERT INTO countries
    (
      name,
      visited
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @visited]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def update()
    sql = "UPDATE countries
    SET
    (
      name,
      visited
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @visited, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM countries
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM countries
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    country = Country.new(result)
    return country
  end

  def self.all()
    sql = "SELECT * FROM countries"
    country_data = SqlRunner.run(sql)
    countries = map_items(country_data)
    return countries
  end

  def self.delete_all
    sql = "DELETE FROM countries"
    SqlRunner.run( sql )
  end

  def self.map_items(country_data)
    return country_data.map { |country| Country.new(country) }
  end

  def self.visited()
    sql = "SELECT * FROM countries WHERE visited = 't';"
    visited = SqlRunner.run(sql)
    return visited.map {|country|Country.new(country)}
  end
end
