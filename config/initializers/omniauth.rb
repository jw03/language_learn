    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, '1084161901697011', '5f1cdb94ee351069cb0f1c46cb4e799c'
    end