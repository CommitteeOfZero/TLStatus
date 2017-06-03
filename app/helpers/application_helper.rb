module ApplicationHelper
  def friendly_stage_name(db_name)
    table = {
      "untouched" => "Untouched",
      "translation" => "In translation",
      "tlc" => "TLC",
      "editing" => "Editing",
      "review" => "TL review",
      "finalised" => "Finalised"
    }
    return table[db_name]
  end
end
