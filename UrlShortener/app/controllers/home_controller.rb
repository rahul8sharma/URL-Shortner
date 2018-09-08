class HomeController < ApplicationController
  def index
    if params[:search_orginal_url].present?
      @url_link = UrlLink.find_or_create_by!(orginal_url: params[:search_orginal_url])
      respond_to do |format|
        format.html
        format.js
      end
    elsif params[:path].present?
      url_link = UrlLink.find_by_generated_url(params[:path])
      if url_link.present?
        url_link.update_attributes(hit_count: url_link.hit_count + 1)
        redirect_to(url_link.orginal_url)
      end
    end

    @url_links = @url_links = UrlLink.order(hit_count: :desc).limit(100)
  end
end
