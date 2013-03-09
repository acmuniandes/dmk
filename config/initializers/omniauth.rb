Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "327891523972361", "9cff3f1fbb55cbcad47a75672ac0a163"
end