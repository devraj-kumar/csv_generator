class UsersController < ApplicationController
  def index
    render json: UsersPresenter.new(resources).present
  end

  def download_report
    file_record = GenerateUserOrderCsvJob.perform_later(resource.id)
    render json: { job_id: file_record.job_id }
  end

  def download_report_status
    if file_record.present?
      render json: { status: 'complete', file_link: url_for(file_record.file) }
    else
      render json: { status: 'pending' }
    end
  end

  private

  def resources
    User.all
  end

  def resource
    User.find(params[:id])
  end

  def file_record
    @_file_record ||= FileRecord.find_by(job_id: params[:job_id])
  end
end
