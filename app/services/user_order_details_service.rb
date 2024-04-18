require 'csv'

class UserOrderDetailsService
  def initialize(user:)
    @user = user
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << ['USERNAME', 'USER_EMAIL', 'PRODUCT_CODE', 'PRODUCT_NAME', 'PRODUCT_CATEGORY', 'ORDER_DATE']
      order_details.each do |order|
        csv << [
          @user.username,
          @user.email,
          order.product.code,
          order.product.name,
          order.product.category,
          order.order_date.strftime('%Y-%m-%d')
        ]
      end
    end
  end

  private

  def order_details
    @user.orders.includes(:product)
  end
end
