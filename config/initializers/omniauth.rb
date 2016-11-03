    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, '679127685598684', 'c9ddaa08ab545bd0a8a91211d9500ea8'
    end