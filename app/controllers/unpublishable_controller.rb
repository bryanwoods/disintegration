class UnpublishableController < ApplicationController
  attr_reader :project, :body, :index

  def show
    @project ||= Project.where(publication: "unpublishable").last
    @body = @project.body

    random_character.present? or return render_png
    write_image

    if RussianRoulette.new.pull_trigger! == :dead
      delete_character(body, random_character)
    end

    render_png
  end

  private

  def random_character
    body.chars.find_index(random_character)
  end

  def random_character
    body.chars.reject { |char| [" ", "\n"].include?(char) }.sample
  end

  def delete_character(body, index)
    project.update_attributes(body: body.tap { |_body| _body[index] = " " })
  end

  def write_image
    canvas = Magick::Image.new(200, 750) do |c|
      c.background_color = "Transparent"
    end

    gc = Magick::Draw.new
    gc.font_family = "Times New Roman"

    gc.pointsize(16)
    gc.text(20, 30, body)
    gc.draw(canvas)

    canvas.write("#{Rails.root}/#{image_path}")
  end

  def render_png
    send_file(image_path, type: 'image/png', disposition: 'inline')
  end

  def image_path
    "public/images/unpublishable.png"
  end
end
