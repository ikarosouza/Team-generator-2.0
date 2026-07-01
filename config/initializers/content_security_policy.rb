Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src :self, :https, :data, "https://cdnjs.cloudflare.com", "https://fonts.gstatic.com"
    policy.img_src :self, :https, :data
    policy.object_src :none
    policy.script_src :self, :https, "https://cdn.jsdelivr.net"
    policy.style_src :self, :https, "https://cdn.jsdelivr.net", "https://cdnjs.cloudflare.com", "https://fonts.googleapis.com"
  end

  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src style-src]
end
