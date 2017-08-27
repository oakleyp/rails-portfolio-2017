class RatingsController < ApplicationController
  def create
    #binding.pry
    #update rating if ip_address already exists in DB
    @rating = Rating.where({ip_address: request.remote_ip})
    if @rating.count > 0
      if @rating.update(rating_params)
        @message = 'Your rating has been updated successfully!'
      else 
        @errors = @rating.errors.full_messages
      end
    else 
      @rating = Rating.new(rating_params)
      @rating[:ip_address] = request.remote_ip
      if @rating.save
        @message = 'Your rating has been posted successfully. Thanks for your feedback!'
      else 
        @errors = @rating.errors.full_messages
      end
    end
    if !@errors.nil?
      render json: {status: 'failure', message: @errors}
    else 
      render json: {status: 'success', message: @message}
    end
  end

  def update
  end

  def index
    render json: Rating.all
  end

  private 
  
  def rating_params
    params.require(:rating).permit(:stars, :comment)
  end
end
