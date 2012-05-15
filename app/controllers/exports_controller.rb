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
    exported_data = ExportedData.export(:to_gdocs)
    render json: {ping: ping_export_path(exported_data.id)}
  end
end
