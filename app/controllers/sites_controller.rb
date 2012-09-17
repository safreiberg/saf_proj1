class SitesController < ApplicationController
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

    if params[:page_id] && params[:duration]
      logger.debug "increasing hit for page"

      @duration = params[:duration].to_i
      logger.debug "got duration: " + @duration.to_s
      @page_id = "Site: " + @name.to_s + ", Page: " + params[:page_id].to_s
      @page = Page.where(:name => @page_id).first_or_create({ :site_id => @name, :hits => 0, :total_duration => 0, :name => @page_id })
      @page.increaseHitCount
      @page.increaseTotalDuration(@duration)
      @site.increaseTotalDuration(@duration)
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
