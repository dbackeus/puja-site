module ApplicationHelper
  def page_title
    @page_title || "Puja site [missing @page_title]"
  end

  def country_select_with_priority(form_builder)
    form_builder.input :country, priority: [request.location.country], include_blank: false
  rescue CountrySelect::CountryNotFoundError
    form_builder.input :country, include_blank: false
  end

  def glyph_icon(name)
    %(<span class="glyphicon glyphicon-#{name}"></span>).html_safe
  end
end
