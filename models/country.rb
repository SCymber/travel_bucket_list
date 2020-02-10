require_relative('../db/sql_runner')

class Country

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO countries
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
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

end
