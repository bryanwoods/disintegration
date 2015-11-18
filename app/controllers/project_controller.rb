class ProjectController < ApplicationController
  before_filter :set_project

  def index
    response.headers.delete("X-Frame-Options")
  end

  def destroy
    body = @project.body
    index = body.chars.find_index(params[:id])

    if @project.update_attributes(body: body.tap { |_body| _body[index] = " " })
      head :ok
    else
      head :bad_request
    end
  end

  private

  def set_project
    @project ||= Project.first
  end
end
