Rails.application.routes.draw do
  # Routes for the Inspiration resource:

  # CREATE
  post("/insert_inspiration", { :controller => "inspirations", :action => "create" })
          
  # READ
  get("/inspirations", { :controller => "inspirations", :action => "index" })
  
  get("/inspirations/:path_id", { :controller => "inspirations", :action => "show" })
  
  # UPDATE
  
  post("/modify_inspiration/:path_id", { :controller => "inspirations", :action => "update" })
  
  # DELETE
  get("/delete_inspiration/:path_id", { :controller => "inspirations", :action => "destroy" })

  #------------------------------

  # Routes for the Update resource:

  # CREATE
  post("/insert_update", { :controller => "updates", :action => "create" })
          
  # READ
  get("/updates", { :controller => "updates", :action => "index" })
  
  get("/updates/:path_id", { :controller => "updates", :action => "show" })
  
  # UPDATE
  
  post("/modify_update/:path_id", { :controller => "updates", :action => "update" })
  
  # DELETE
  get("/delete_update/:path_id", { :controller => "updates", :action => "destroy" })

  #------------------------------

  # Routes for the Project resource:

  # CREATE
  post("/insert_project", { :controller => "projects", :action => "create" })
          
  # READ
  get("/projects", { :controller => "projects", :action => "index" })
  
  get("/projects/:path_id", { :controller => "projects", :action => "show" })
  
  # UPDATE
  
  post("/modify_project/:path_id", { :controller => "projects", :action => "update" })
  
  # DELETE
  get("/delete_project/:path_id", { :controller => "projects", :action => "destroy" })

  #------------------------------

  # Routes for the Follow resource:

  # CREATE
  post("/insert_follow", { :controller => "follows", :action => "create" })
          
  # READ
  get("/follows", { :controller => "follows", :action => "index" })
  
  get("/follows/:path_id", { :controller => "follows", :action => "show" })
  
  # UPDATE
  
  post("/modify_follow/:path_id", { :controller => "follows", :action => "update" })
  
  # DELETE
  get("/delete_follow/:path_id", { :controller => "follows", :action => "destroy" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Style resource:

  # CREATE
  post("/insert_style", { :controller => "styles", :action => "create" })
          
  # READ
  get("/styles", { :controller => "styles", :action => "index" })
  
  get("/styles/:path_id", { :controller => "styles", :action => "show" })
  
  # UPDATE
  
  post("/modify_style/:path_id", { :controller => "styles", :action => "update" })
  
  # DELETE
  get("/delete_style/:path_id", { :controller => "styles", :action => "destroy" })

  #------------------------------

  # Routes for the Artwork resource:

  # CREATE
  post("/insert_artwork", { :controller => "artworks", :action => "create" })
          
  # READ
  get("/artworks", { :controller => "artworks", :action => "index" })
  
  get("/artworks/:path_id", { :controller => "artworks", :action => "show" })
  
  # UPDATE
  
  post("/modify_artwork/:path_id", { :controller => "artworks", :action => "update" })
  
  # DELETE
  get("/delete_artwork/:path_id", { :controller => "artworks", :action => "destroy" })

  #------------------------------

  # Routes for the Artist resource:

  # CREATE
  post("/insert_artist", { :controller => "artists", :action => "create" })
          
  # READ
  get("/artists", { :controller => "artists", :action => "index" })
  
  get("/artists/:path_id", { :controller => "artists", :action => "show" })
  
  # UPDATE
  
  post("/modify_artist/:path_id", { :controller => "artists", :action => "update" })
  
  # DELETE
  get("/delete_artist/:path_id", { :controller => "artists", :action => "destroy" })

  #------------------------------

  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"

  root "projects#index"
  
end
