class VersionsController < ApplicationController

  def index

  end

  def show
    @version = Version.find(params[:id])
    @character_lines = @version.all_chars
  end

  def create
    version = Version.create
    Analyzer.call(version_params[:url], version)
    redirect_to version_path(version)
  end

  def new

  end

  private

  def version_params
    params.permit(:url)
  end

end
