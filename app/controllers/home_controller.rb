class HomeController < ApplicationController
  def index
    @posts = Post.limit(3)  # Adjust the number based on how many recent posts you want to display
    @contests = Contest.limit(3)  # Adjust for contests
    @random_potions = Potion.order("RANDOM()").limit(3)
    render :index
  end
  
  def show
    render :show
  end

  def image_number_for_category(category)
    image_ranges = {
      "Love" => 1..5,
      "Mind Control" => 6..10,
      "Strength" => 11..15,
      "Healing" => 16..20,
      "Invisibility" => 21..25
    }
  
    range = image_ranges[category]
    rand(range)
  end
  

end
