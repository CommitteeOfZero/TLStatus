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
end
