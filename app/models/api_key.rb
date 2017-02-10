class ApiKey < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 15}

  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
