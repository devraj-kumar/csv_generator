require 'csv'

module CsvImporter
  def self.import_users(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      email = row['EMAIL']
      next if email.blank?

      user = User.find_by(email: email)

      if user.present?
        puts "User '#{email}' already exists."
      else
        User.create!(username: row['USERNAME'], email: email, phone: row['PHONE'])
      end
    end
  end

  def self.import_products(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      code = row['CODE']
      next if code.blank?

      product = Product.find_by(code: code)

      if product.present?
        puts "Product '#{code}' already exists."
      else
        Product.create!(code: code, name: row['NAME'], category: row['CATEGORY'])
      end
    end
  end

  def self.import_orders(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      user = User.find_by(email: row['USER_EMAIL'])
      product = Product.find_by(code: row['PRODUCT_CODE'])

      if user.blank? || product.blank?
        puts "Order skipped: User Emial '#{row['USER_EMAIL']}' - Product code '#{row['PRODUCT_CODE']}'"
      else
        Order.create(user: user, product: product, order_date: row['ORDER_DATE'])
      end
    end
  end
end
