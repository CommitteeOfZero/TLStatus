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
end
