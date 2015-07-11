# unless defined?(DB)
#   db_options = {adapter: 'postgres', host: ENV['DB_HOST'], port: ENV['DB_PORT'], database: ENV['DB_NAME'], user: ENV['DB_UNAME'], password: ENV['DB_PWORD']}
#   DB = ENV['ENVIRONMENT'] == 'production' ? Sequel.connect(db_options) : Sequel.sqlite
# end
#
# unless DB.tables.include?(:contents)
#   DB.create_table :contents do
#     primary_key :id
#     String :title
#     String :url
#     Time :published
#     String :author
#   end
# end
