SafProj1::Application.routes.draw do
  ## This line takes care of the hits registered by the JS at the client browser.
  match "/sites/:id/*site/" => "sites#visit"

  ## This line takes care of requests to see analytics for a site
  match "/sites/:id/" => "sites#list_site"

  ## This line takes care of requests to see analytics for the entire engine
  match "/sites" => "sites#list"

  root :to => "welcome#index"

  ## Something about JS????
  match "/restricted/resource" => "sites#resource_preflight", :constraints => { :method => "OPTIONS" }
  match "/restricted/resource" => "sites#resource"

  ## Catches all of the remaining requests and sends them to a 404 page.
  match "*path" => "welcome#sorry"
end
