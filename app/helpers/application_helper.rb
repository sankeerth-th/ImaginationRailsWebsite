# frozen_string_literal: true

module ApplicationHelper
  BOOTSTRAP_ALERT_CLASS = {
    'success' => 'alert-success',
    'error'   => 'alert-danger',
    'notice'  => 'alert-info',
    'alert'   => 'alert-danger',
    'warn'    => 'alert-warning'
  }.freeze

def cart_items_count
    if user_signed_in? && current_user.cart
      current_user.cart.cart_items.sum(:quantity) # Total count of all items in the cart
    else
      0
    end
  end

  def alert_class(flash_key)
    BOOTSTRAP_ALERT_CLASS.fetch(flash_key, 'alert-info')
  end
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

