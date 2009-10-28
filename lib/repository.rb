class Gitlocker::Repository
  def self.destroy(site, params)
    Gitlocker::HTTP.request :delete, "#{site}/repositories/#{params[:repo_id]}"
  end
end

