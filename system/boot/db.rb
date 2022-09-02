Container.register_provider(:db) do |container|
  prepare do
    require "rom"
    require "rom-sql"

    connection = Sequel.sqlite("database.db")
    register('db.connection', connection)
    register('db.config', ROM::Configuration.new(:sql, connection))
  end

  start do
    puts "START"

    #container['persistance.rom'].gateways[:default].run_migrations
  end

  stop do
    puts "STOP"
  end
end
