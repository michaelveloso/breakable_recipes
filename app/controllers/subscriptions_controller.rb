class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:success] = "You have successfully subscribed to this recipe!"
    else
      flash[:errors] = @subscription.errors
    end
    redirect_to shared_recipe_path(this_recipe)
  end

  def destroy
    @subscription = Subscription.find_by(user: current_user, recipe_id: recipe_id)
    @subscription.destroy
    flash[:success] = "You have successfully unsubscribed from this recipe."
    redirect_to recipes_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:recipe_id).merge(user: current_user)
  end

  def this_recipe
    Recipe.find(recipe_id)
  end

  def recipe_id
    params[:subscription][:recipe_id]
  end
end
