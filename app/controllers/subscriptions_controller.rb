class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:success] = "You have successfully subscribed to this recipe!"
    else
      flash[:errors] = @subscription.errors
    end
    redirect_to shared_recipe_path(this_recipe)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:recipe_id).merge(user: current_user)
  end

  def this_recipe
    Recipe.find(params[:subscription][:recipe_id])
  end
end
