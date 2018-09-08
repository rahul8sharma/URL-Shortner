class UrlLink < ActiveRecord::Base
	before_create :set_token

	def set_token
		self.generated_url = UrlLink.generate_token
	end

  def self.generate_token
    loop do
      # random_token = SecureRandom.urlsafe_base64(nil, false)
      random_token = SecureRandom.hex(4)
      break random_token unless UrlLink.exists?(generated_url: random_token)
    end
  end
end
