module ApplicationHelper
  def page_title
    @page_title || "Puja site [missing @page_title]"
  end
end
