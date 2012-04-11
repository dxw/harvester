class ExportsController < ApplicationController
  def show
  end

  def to_gdocs
    session = GoogleSpreadsheet.login(HarvesterNg::Application::config.google_docs[:username], HarvesterNg::Application::config.google_docs[:password])
    datetime = Time.zone.now.iso8601
    spreadsheet = session.create_spreadsheet("Harvester #{datetime}")

    redirect_to spreadsheet.human_url
  end
end
