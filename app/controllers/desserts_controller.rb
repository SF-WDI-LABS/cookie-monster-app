class DessertsController < ApplicationController
  before_action :require_login, except: [:index]
  # before_action :require_login, only: [:show, :favorite, :save_as_favorite]

  # GET /desserts
  def index
    @desserts = Dessert.all
  end

  # GET /desserts/1
  def show
    if session[:favorite_dessert_id] == params[:id]
      @is_favorite = true
    else
      @is_favorite = false
    end

    ## CHALLENGE 4: This is my favorite dessert!
    ### Detect whether the dessert the user is viewing
    ### is their favorite_dessert, and add the words
    ### 'FAVORITE dessert' in the `views/desserts/show.html.erb` template

    @dessert = Dessert.find(params[:id])
    # render 'show'
  end

  # GET /desserts/favorite
  # Shows the user's favorite dessert (if set in the session)
  def favorite
    ## CHALLENGE 3: Render my favorite_dessert!
    ### Check my session for my `favorite_dessert_id`
    ### and then render my favorite dessert
    ### AS-IS this will raise an error
    favorite_dessert_id = session[:favorite_dessert_id] # CHANGE THIS
    @dessert = Dessert.find(favorite_dessert_id)
    @is_favorite = true
    render 'show'
  end

  # POST /desserts/1/save_as_favorite
  # Sets the user's favorite dessert in their session
  def save_as_favorite
    session[:favorite_dessert_id] = params[:id] # SET favorite
    flash[:notice] = "dessert #{params[:id]} saved in session as favorite!"
    redirect_to root_path
  end

  private

  def require_login
    redirect_to root_path and return if not is_logged_in
  end

  def is_logged_in
    cookies[:can_access] == "yeah"
  end

end
