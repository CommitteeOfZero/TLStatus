module ApplicationHelper
  def friendly_stage_names
    {
      "untouched" => "Untouched",
      "translation" => "In translation",
      "tlc" => "TLC",
      "editing" => "Editing",
      "review" => "TL review",
      "finalised" => "Finalised"
    }
  end
  
  def avatar_for(user)
    return "" if (user.nil? || !user.avatar.present?)
    image_tag user.avatar.url :thumb
  end
  
  def display_time(time)
    "#{time_ago_in_words(time)} ago (#{time})"
  end
  
  def link_to_script_version(audit)
    if audit.version == audit.auditable.revisions.count
      return link_to "Version #{audit.version} (latest version)",
                     edit_script_path(audit.auditable)
    else
      return link_to "Version #{audit.version}",
                      version_of_script_path(id: audit.auditable.id, version: audit.version)
    end
  end
  
  def glyphicon(name)
    "<span class='glyphicon glyphicon-#{name}' aria-hidden='true'></span>"
  end
  
  def parsed_comment(audit)
    return "" if audit.comment.blank?
    if audit.version == audit.auditable.revisions.count
      # gsub seems to break on an ActiveSupport::SafeBuffer, hence the to_str
      str = h(audit.comment).to_str.gsub(/(?<!&)#(\d+)/) do
        link_to "##{$1}", edit_script_path(audit.auditable) + "#line_#{$1}"
      end
    else
      str = h(audit.comment).to_str.gsub(/(?<!&)#(\d+)/) do
        link_to "##{$1}", version_of_script_path(id: audit.auditable.id,
                                                 version: audit.version) + "#line_#{$1}"
      end
    end
    str.gsub!(/\r?\n/, "<br>")
    return str.html_safe
  end
  
  def markdown(text)
    return "" if text.nil?
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true, safe_links_only: true, hard_wrap: true), 
                                          tables: true, fenced_code_blocks: true,
                                          autolink: true, strikethrough: true,
                                          underline: true)
    return @markdown.render(text).html_safe
  end
end
