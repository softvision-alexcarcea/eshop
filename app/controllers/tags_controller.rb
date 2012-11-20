class TagsController < ApplicationController
  def search
    source = params[:query].blank? ?
      ActsAsTaggableOn::Tag :
      ActsAsTaggableOn::Tag.named_like(params[:query])
    @tags = source.page(params[:page]).per(params[:per])
    
    respond_to do |format|
      format.json { render json: @tags.to_json }
    end
  end
end
