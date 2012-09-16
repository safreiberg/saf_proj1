class SitesController < ApplicationController
  #before_filter :cors_preflight_check
  #after_filter :set_cors_headers

  def list

  end

  def list_site
    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0 })
  end

  ## Note that we create the record for a site if the site has never been visited.
  def visit
    resource

    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0 })
    @site.increaseHitCount
    logger.debug "increasing hit for site"

    if params[:page_id]
      logger.debug "increasing hit for page"
      @page_id = "Site: " + @name.to_s + ", Page: " + params[:page_id].to_s
      @page = Page.where(:id => @page_id).first_or_create({ :site_id => @name, :hits => 0, :total_duration => 0, :id => @page_id })

      @page.increaseHitCount
    end
  end

  def set_cors_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
    headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
    headers["Access-Control-Max-Age"] = "3600"
  end

  def cors_preflight_check
    if request.method == :options
      headers["Access-Control-Allow-Origin"] = "*"
      headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
      headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-Prototype-Version"
      headers["Access-Control-Max-Age"] = "3600"
      render :text => '', :content_type => "text/plain"
    end
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
