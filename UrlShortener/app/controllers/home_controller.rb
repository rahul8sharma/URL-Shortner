class HomeController < ApplicationController
  def index
    @url_links = @url_links = UrlLink.order(hit_count: :desc).limit(100)
    if params[:search_name].present?
      @url_link = UrlLink.find_by_orginal_url(params[:search_name])
      @is_new_url = false
      unless @url_link.present?
        @is_new_url = true
        short_url = UrlLink.generate_token
        @url_link = UrlLink.create!(orginal_url: params[:search_name], generated_url: short_url, hit_count: 0)
      end
      @generated_url = request.base_url + '/' + @url_link.generated_url
      respond_to do |format|
        format.html
        format.js
      end
    end
    if params[:path].present?
      @url_link = UrlLink.find_by_generated_url(params[:path])
      if @url_link.present?
        @url_link.update_attributes(hit_count: @url_link.hit_count + 1)
        redirect_to(@url_link.orginal_url)
      end
    end
  end
end
