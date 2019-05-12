require 'mimemagic'

class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my]

  # GET /images
  def index
    @images = Image.where(is_public: true).limit(50).order('id')
  end

  # GET /images/my
  def my
    @images = Image.where(user_id: current_user.id)
  end

  # GET /images/1
  def show
    file_path = Rails.root.join('public', 'uploads', params[:id].gsub('_', '/'))
    mime = MimeMagic.by_path(file_path)
    send_data(File.read(file_path), type: mime.try(:type) || 'application/octet-stream')
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  def create
    FileUtils.mkdir_p(Rails.root.join('public', 'uploads', current_user.id.to_s))
    filename = image_params[:file].original_filename.delete('^0-9a-zA-Z.')
    File.open(Rails.root.join('public', 'uploads', current_user.id.to_s, filename), 'wb') do |file|
      file.write(image_params[:file].read)
    end

    @image = Image.new(
      user_id: current_user.id,
      filename: filename,
      is_public: image_params[:is_public],
    )

    if @image.save
      redirect_to '/', notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:file, :is_public)
    end
end
