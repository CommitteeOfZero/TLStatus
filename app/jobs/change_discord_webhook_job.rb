class ChangeDiscordWebhookJob < ApplicationJob
  queue_as :default

public
  def perform(change)
    colors = {
      "untouched" => 0,
      "translation" => 0x375a7f,
      "tlc" => 0x3498db,
      "editing" => 0x00bc8c,
      "review" => 0xf39c12,
      "finalised" => 0xe74c3c
    }
    
    embed = {
      title: "`#{change.auditable.name}` updated", # even though it's the title, discord will otherwise parse markdown in the name
      url: Rails.application.routes.url_helpers.edit_script_url(change.auditable),
      timestamp: change.created_at.iso8601,
      author: {
        name: change.user.name
      },
      fields: []
    }
    
    if change.user.avatar.present?
      avatar_url = URI.join(ActionController::Base.asset_host, change.user.avatar.url(:thumb))
      embed[:thumbnail] = {
        url: avatar_url
      }
      # this only works in prod because discord only reads from standard ports
    end
    
    if change.audited_changes.include? "stage"
      embed[:fields] << {
        name: "Stage",
        value: "changed from **#{ApplicationController.helpers.friendly_stage_names[change.audited_changes["stage"].first]}** to **#{ApplicationController.helpers.friendly_stage_names[change.audited_changes["stage"].second]}**",
        inline: true # I'm not sure what this does but it seems good to have
      }
      # auditable state is still before update, thus we need to get audited_changes.second here
      embed[:color] = colors[change.audited_changes["stage"].second]
    else
      embed[:color] = colors[change.auditable.stage]
    end
    
    if change.comment.present?
      embed[:fields] << {
        name: "Comment",
        value: change.comment,
        inline: true
      }
    end
    
    HTTParty.post(ENV['DISCORD_CHANGE_WEBHOOK'], body: {embeds: [embed]}.to_json,
                                                 headers: {
                                                   "Content-Type" => "application/json"
                                                 })
  end
end
