class TlstatusAudit < Audited::Audit
  after_create :post_notification
  
  def post_notification
    ChangeDiscordWebhookJob.perform_later self if self.action == "update" && self.auditable_type == "Script"
  end
end