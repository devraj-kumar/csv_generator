namespace :import do
  desc 'Import data from CSV files'

  task :data => :environment do
    CsvImporter.import_users('csv/users.csv')
    CsvImporter.import_products('csv/products.csv')
    CsvImporter.import_orders('csv/order_details.csv')
    puts 'Data imported successfully!'
  end
end
