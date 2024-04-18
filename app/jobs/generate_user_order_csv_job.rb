class GenerateUserOrderCsvJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    csv_data = UserOrderDetailsService.new(user: user).generate_csv

    file_record = FileRecord.create!(job_id: job_id)
    file = file_record
            .file
            .attach(
              io: StringIO.new(csv_data),
              filename: "#{user.username}_orders.csv",
              content_type: 'text/csv'
            )
  end
end
