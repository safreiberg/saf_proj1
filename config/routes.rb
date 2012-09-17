SafProj1::Application.routes.draw do
  ## Takes care of the OPTIONS preflight stuff for the cross-site requests.
  match "/*path" => "sites#resource_preflight", :constraints => { :method => "OPTIONS" }

  ## This line takes care of the hits registered by the JS at the client browser.
  match "/sites/:id/:page_id/:duration" => "sites#visit", :constraints => {:page_id => /.*/}

  ## This line takes care of requests to see analytics for a site
  match "/sites/:id/" => "sites#list_site"

  ## This line takes care of requests to see analytics for the entire engine
  match "/sites" => "sites#list"

  root :to => "welcome#index"

  ## Catches all of the remaining requests and sends them to a 404 page.
  match "*path" => "welcome#sorry"
end
