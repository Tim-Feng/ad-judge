module ApplicationHelper
  def fix_embedded_url(str)
    str.split("_").last
  end
end
