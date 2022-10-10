class PhotosController < ApplicationController
  include Oauth

  before_action :require_login
  before_action :set_photo, only: %i[ show edit update destroy twitter]

  # GET /photos or /photos.json
  def index
    @authorize_endpoint = authorize_endpoint
    @photos = Photo.all.order(created_at: "DESC")
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  def twitter
    require 'net/http'
    require 'uri'
    require 'json'
    uri = URI.parse(twitter_endpoint)
    req = Net::HTTP::Post.new(uri)
    req["Authorization"] = "Bearer " + session[:access_token]
    req["Content-Type"] = "application/json"
    photo_url = 'http://localhost:3000/photos/' + @photo.id.to_s
    post_data = {'text' => @photo.title, 'url' => photo_url}.to_json
    req.body = post_data
    req_options = {
     use_ssl: uri.scheme == "https"
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end
    redirect_to photos_url
  end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_url
    else
      flash[:danger] = @photo.errors.full_messages.join(',')
      redirect_to action: :new
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:title, :image)
    end
end
