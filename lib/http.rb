class Gitlocker::HTTP
  # Wrapper in case I switch out Patron
  def self.request(method, url, params = {})
    patron = Patron::Session.new
    patron.send method, url, params
  end
end

