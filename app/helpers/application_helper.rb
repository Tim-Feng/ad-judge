module ApplicationHelper
  def fix_embedded_url(str)
    str.split("/").last
  end
end
