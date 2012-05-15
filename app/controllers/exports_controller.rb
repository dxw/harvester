require 'jobs/export'

class ExportsController < ApplicationController
  def show
  end

  def ping
    if params['exported_data_id'].nil?
      render json: {error: 'not_found'}, status: :not_found
    else
      exported_data = ExportedData.find(params['exported_data_id'])
      if exported_data.waiting?
        render json: {waiting: true}
      else
        render json: {waiting: false, uri: exported_data.uri}
      end
    end
  end

  def to_gdocs
    if params[:exported_data_id].nil?
      redirect_to to_gdocs_export_path(ExportedData.export(:to_gdocs))
    else
      exported_data = ExportedData.find(params[:exported_data_id])
      if exported_data.waiting?
        # Just render the view
      else
        redirect_to exported_data.uri
      end
    end
  end
end
