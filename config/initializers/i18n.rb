require 'redcarpet'

module I18n::Backend::Markdown
  def translate(*args)
    markdown.render(super)
  end

  private

  def markdown
    @markdown ||= begin
      Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    end
  end
end

I18n::Backend::Simple.send(:include, I18n::Backend::Markdown)
