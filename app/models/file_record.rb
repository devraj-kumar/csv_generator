class FileRecord < ApplicationRecord
  has_one_attached :file

  validates :job_id, presence: true
end
