require 'digest'

class SitesController < ApplicationController
  def list
  end

  def list_site
  end

  ## Note that we create the record for a site if the site has never been visited.
  def visit
    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0 })
    @site.increaseHitCount

    if params[:page] && params[:site_id]
      @page_url = params[:page]
      @id = Digest::SHA1.hexdigest @page_url
      @page = Page.where(:id => @id).first_or_create({ :site_id => @name, :hits => 0, :total_duration => 0, :site_id => @site_id })

      @page.increaseHitCount
    end
  end

  def set_cors_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
    headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
    headers["Access-Control-Max-Age"] = "3600"
  end

  def resource_preflight
    set_cors_headers
    render :text => "", :content_type => "text/plain"
  end

  def resource
    set_cors_headers
    render :text => "OK here is your restricted resource!"
  end
end
