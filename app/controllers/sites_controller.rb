class SitesController < ApplicationController
  def list
  end

  ## Note that we create the record for a site if the site has never been visited.
  def visit
    @name = params[:id]

    @site = Site.where(:name => @name).first_or_create({ :name => @name, :hits => 0 })

    @site.increaseHitCount
  end
end
