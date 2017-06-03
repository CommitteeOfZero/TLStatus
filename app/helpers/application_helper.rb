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
end
