class ProjectController < ApplicationController
  attr_reader :project, :body, :index
  before_filter :delete_frame_options_header

  def poems
    @project = Project.where(publication: nil).last
    @body = @project.body
    random_character.present? or return render_png
    write_queen_mobs_image
    delete_character(body, random_character)
    render_queen_mobs_png
  end

  def diagram
    @project = Project.where(publication: "diagram").last
    @body = @project.body
    random_character.present? or return render_png
    write_diagram_image
    delete_character(body, random_character) if Time.now.to_i % 3 == 0
    render_diagram_png
  end

  def destroy
    random_character.present? or return head(:ok)
    delete_character(body, random_character)
    head(:ok)
  end

  private

  def random_character
    body.chars.find_index(random_character)
  end

  def random_character
    body.chars.reject { |char| [" ", "\n"].include?(char) }.sample
  end

  def delete_frame_options_header
    response.headers.delete("X-Frame-Options")
  end

  def delete_character(body, index)
    project.update_attributes(body: body.tap { |_body| _body[index] = " " })
  end

  def write_queen_mobs_image
    canvas = Magick::Image.new(500, 1700) do |c|
      c.background_color = "Transparent"
    end

    gc = Magick::Draw.new

    gc.pointsize(15)
    gc.text(50, 50, body)
    gc.draw(canvas)

    canvas.write("#{Rails.root}/#{image_path}")
  end

  def write_diagram_image
    canvas = Magick::Image.new(600, 800) do |c|
      c.background_color = "Transparent"
    end

    gc = Magick::Draw.new

    gc.pointsize(15)
    gc.text(50, 50, body)
    gc.draw(canvas)

    canvas.write("#{Rails.root}/#{diagram_image_path}")
  end

  def render_queen_mobs_png
    send_file(image_path, type: 'image/png', disposition: 'inline')
  end

  def render_diagram_png
    send_file(diagram_image_path, type: 'image/png', disposition: 'inline')
  end

  def image_path
    "public/images/poems.png"
  end

  def diagram_image_path
    "public/images/diagram.png"
  end
end
