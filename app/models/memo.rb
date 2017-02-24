class Memo < ApplicationRecord
  belongs_to :user
  has_many :comment
  require "redcarpet"

  def rendered_body
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(filter_html: true)
      @markdown = Redcarpet::Markdown.new(renderer)
    end

    @markdown.render(body)
  end
end
