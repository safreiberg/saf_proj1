class SitesController < ApplicationController
  before_filter :checkAuth, :only => [:createSite, :list_site, :list, :viewSiteSpecifics]
  after_filter :checkPermission, :only => [:list_site, :viewSiteSpecifics, :list]

  def checkAuth
    if !session[:current_user]
      render :text => "You're not signed in! Go <a href='/signin'>here</a>."
    end
  end

  def checkPermission
    if @site.nil? or (@site.isopen == 0 and @site.ownedby != session[:current_user])
      render :text => "Sorry bro, you don't have permission for this site."
    end
  end

  # This should be used to claim a site as yours. If the site is already claimed (not by admin) the request will be rejected.
  def createSite
    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0, :isopen => 0, :ownedby => "admin" })

    if @site.ownedby != "admin"
      render :text => "This site is already claimed."
    else
      @site.ownedby = session[:current_user]
      @site.save
    end
  end

  def list
  end

  def sorry
  end

  def viewSiteSpecifics
    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0, :isopen => 0, :ownedby => "admin" })
  end

  ## Makes sure that a Site is in the database before trying to display the analytics statistics for it.
  def list_site
    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0, :isopen => 0, :ownedby => "admin" })
  end

  ## Note that we create the record for a site if the site has never been visited.
  def visit
    resource

    @name = params[:id]
    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0, :total_duration => 0, :isopen => 0, :ownedby => "admin"})
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

      if params[:location] and params[:hittime]
        logger.debug "we got a location :)"
        @pageview = Pageview.create({ :hittime => params[:hittime].to_i, :location => params[:location], :site_id => @name })
      end

    end
  end

  ## These are necessary for the Cross-Site requests.
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
  ## End Cross-Site request snippets.
end
