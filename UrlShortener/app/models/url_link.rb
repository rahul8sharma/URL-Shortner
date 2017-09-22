class UrlLink < ActiveRecord::Base
  def self.generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless UrlLink.exists?(generated_url: random_token)
    end
  end
end
