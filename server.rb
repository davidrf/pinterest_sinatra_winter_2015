require "sinatra"
require "pg"
require "pry"

set :views, File.join(File.dirname(__FILE__), "app/views")

configure :development do
  set :db_config, { dbname: "pins_development" }
end

configure :test do
  set :db_config, { dbname: "pins_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

get '/pins' do
  @pins = nil
  db_connection do |conn|
    sql_query = "SELECT * FROM pins"
    @pins = conn.exec(sql_query)
  end

  erb :'pins/index'
end

get '/pins/new' do
  erb :'pins/new'
end

get '/pins/:id' do
  @pin = nil
  db_connection do |conn|
    sql_query = "SELECT * FROM pins WHERE id = $1"
    data = [params["id"]]
    @pin = conn.exec_params(sql_query, data).first
  end
  erb :'pins/show'
end

post '/pins' do
  db_connection do |conn|
    sql_query = %(
      INSERT INTO pins (title, description)
      VALUES ($1, $2)
    )
    data = [params["title"], params["description"]]
    conn.exec_params(sql_query, data)
  end
  redirect "/pins"
end
