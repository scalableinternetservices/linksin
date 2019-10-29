module ApplicationHelper

  def full_title(page_title = "")
    base_title = "LinksIn"
    return base_title if page_title.empty?
    return page_title + " | " + base_title
  end

end
