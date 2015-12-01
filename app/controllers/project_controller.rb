require 'RMagick'

class ProjectController < ApplicationController
  before_filter :set_project, :delete_frame_options_header

  def index
  end

  def poems
    body = @project.body

    respond_to do |format|
      format.png do
        random_character = body.chars.reject do
          |char| [" ", "\n"].include?(char)
        end.sample

        index = body.chars.find_index(random_character) or return render_png

        write_image

        @project.update_attributes(
          body: body.tap { |_body| _body[index] = " " }
        )

        render_png
      end
    end
  end

  private

  def set_project
    @project ||= Project.last
  end

  def delete_frame_options_header
    response.headers.delete("X-Frame-Options")
  end

  def write_image
    canvas = Magick::Image.new(500, 1700) do |c|
      c.background_color = "Transparent"
    end

    gc = Magick::Draw.new

    gc.pointsize(15)
    gc.text(50, 50, @project.body)
    gc.draw(canvas)

    canvas.write("#{Rails.root}/public/images/poems.png")
  end

  def render_png
    send_file(
      'public/images/poems.png',
      type: 'image/png',
      disposition: 'inline'
    )
  end
end
