class Gitlocker::Document
  def self.create(site, params)
    Gitlocker::HTTP.request :post, "#{site}/repositories/#{params[:repo_id]}/documents", params
  end

  def self.update(site, params)
    Gitlocker::HTTP.request :put, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:document][:id]}", params
  end

  def self.destroy(site, params)
    Gitlocker::HTTP.request :delete, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:id]}", params
  end

  def self.find(site, params)
    response = Gitlocker::HTTP.request :get, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:id]}"
    response.body
  end

  def self.version(site, params)
    response = Gitlocker::HTTP.request :get, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:id]}/version/#{params[:version]}"
    response.body
  end

  def self.revert(site, params)
    response = Gitlocker::HTTP.request :get, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:id]}/revert/#{params[:version]}"
    response.body
  end

  def self.versions(site, params)
    response = Gitlocker::HTTP.request :get, "#{site}/repositories/#{params[:repo_id]}/documents/#{params[:id]}/versions"
    response.body
  end
end
