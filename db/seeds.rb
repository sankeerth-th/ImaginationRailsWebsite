# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user1 = User.find_or_create_by!(email: 'alice@email.com') do |user|
  user.password = 'password'
  # Add any other user fields here
end

user2 = User.find_or_create_by!(email: 'bob@email.com') do |user|
  user.password = 'password'
  # Add any other user fields here
end

user3 = User.find_or_create_by!(email: 'bart@email.com') do |user|
  user.password = 'password'
  # Add any other user fields here
end

user4 = User.find_or_create_by!(email: 'lisa@email.com') do |user|
  user.password = 'password'
  # Add any other user fields here
end

# Vendors
vend1 = Vendor.create!(
  business_name: 'Business Name1',
  desc: "Business Desc 1",
  userobj: user1
)

vend2 = Vendor.create!(
  business_name: 'Business Name 2',
  desc: "Business Desc 2",
  userobj: user2
)

potion1 = Potion.create!(
  category: "Love",
  duration: "2 hours",           
  effect: "Creates feelings of love",           
  name: "Love Potion",             
  origin: "Enchanted Forest",            
  potency: "High",            
  recommended_age: 18,    
  source_description: "Brewed with rare flowers", 
  price: 15,
  stock: rand(5..20),
  vendor: vend1
)

image_path1 = Rails.root.join('app', 'assets', 'images', 'image_120.webp')
potion1.images.attach(io: File.open(image_path1), filename: 'image_120.webp')

potion2 = Potion.create!(
  category: "Mind Control",
  duration: "1 hours",           
  effect: "Mind control others",           
  name: "Control Potion",             
  origin: "Enchanted Forest",            
  potency: "Medium",            
  recommended_age: 5,    
  source_description: "Brewed with rare flowers", 
  price: 13,
  stock: rand(5..20),
  vendor: vend1
)

image_path2 = Rails.root.join('app', 'assets', 'images', 'images_2.jpeg')
potion2.images.attach(io: File.open(image_path2), filename: 'images_2.jpeg')

contest1 = Contest.create!(
  title: "Holiday Fire Potion Contest",
  desc: "The holidays are coming up, and we want to keep the fire for brewing alive in your hear. Submit a potion that has some fire attribute for a change at winning 100 gold.",
  end_date: DateTime.parse("31/12/2023 23:00"),
  vendor: vend1
)
contest1_image_path = Rails.root.join('app', 'assets', 'images', 'Potion Contests', 'potion_contest2.webp')
contest1.image.attach(io: File.open(contest1_image_path), filename: 'potion_contest2.webp')

contest2 = Contest.create!(
  title: "Yearly Potion Contest",
  desc: "Submit your best potion for a shoutout on our homepage, and a 1,000 Gold reward.",
  end_date: DateTime.parse("31/12/2023 23:00"),
  vendor: vend2
)
contest2_image_path = Rails.root.join('app', 'assets', 'images', 'Potion Contests', 'potion_contest_1.webp')
contest2.image.attach(io: File.open(contest2_image_path), filename: 'potion_contest_1.webp')

post1 = Post.create!(
  title: "Cool Potion",
  content: "This new water breathing potion is lit!",
  user: user1
)

Comment.create!(
  body: "nice take on things",
  post: post1,
  user: user3
)



# Seeds for Potions
themes = ["Love", "Mind Control", "Strength", "Healing", "Invisibility"]
vendors = [vend1] # Assuming you have vendors initialized

image_ranges = {
  "Love" => 1..5,
  "Mind Control" => 6..10,
  "Strength" => 11..15,
  "Healing" => 16..20,
  "Invisibility" => 21..25
}

themes.each do |theme|
  image_range = image_ranges[theme]

  image_range.each do |image_index|
    potion = Potion.create!(
      category: theme,
      duration: "#{rand(1..3)} hours",
      effect: "#{theme} effect",
      name: "#{theme} Potion",
      origin: "Mystical Realm",
      potency: ["Low", "Medium", "High"].sample,
      recommended_age: rand(12..60),
      source_description: ["Brewed with magical herbs", "Brewed with Tea From Assamese Magical Herbs", "High Mountain magical stems with fenix tears"].sample,
      price: rand(10..100),
      stock: rand(5..20),
      vendor: vendors.sample
    )
    
    image_filename = "image_#{image_index}.webp"
    image_path = Rails.root.join('app', 'assets', 'images', image_filename)

    if File.exist?(image_path)
      potion.images.attach(io: File.open(image_path), filename: image_filename)
    else
      Rails.logger.warn "Image file not found for #{image_path}"
    end
  end
end


titles = ['Inferno Elixir', 'Blaze of Glory Potion', 'Fiery Focus Draught', 'Volcanic Vigor Tonic', 'Phoenix Feather Serum', 'Emberlight Vision Elixir', 'Flameheart Brew', 'Scorching Speed Potion', 'Cinder Cloak Concoction', 'Solar Flare Solution']
summaries = ['This potent brew grants the drinker a temporary ability to withstand extreme heat and even walk through flames unscathed, perfect for daring escapes or fire-themed rituals.',
"Upon consumption, this potion enhances the user's charisma and courage, making them exceptionally persuasive and brave, especially in challenging situations, as if they are imbued with the spirit of fire.",
"Designed to sharpen the mind, this potion heightens concentration and mental clarity. It's ideal for scholars and mages seeking to unlock complex magical secrets or solve intricate problems.",
"This tonic boosts physical strength and endurance, simulating the eruptive power of a volcano. It's favored by warriors and adventurers needing an extra burst of energy during intense battles or treks.",
"Infused with mythical phoenix feathers, this serum grants a temporary rejuvenation effect, healing minor wounds and restoring vitality, symbolizing the legendary bird's ability to rise from its ashes.",
"This elixir enhances night vision and allows the user to see through smoke and fog, mimicking the penetrating gaze of a flame in darkness, useful for nocturnal explorations or navigating smoky environments.",
"A potion that warms the body and soul, increasing resilience to cold environments and fostering a sense of inner warmth and courage, akin to sitting beside a cozy hearth fire.",
"Upon ingestion, this potion significantly boosts the drinker's speed for a short duration, as if their feet are lit with swift flames, ideal for quick escapes or rapid pursuits.",
"This mystical mixture creates a thin, protective aura around the user, resembling a cloak of cinders, which provides minor protection against physical attacks and enhances intimidation presence.",
"A dazzling potion that temporarily enhances creativity and artistic inspiration, evoking the unpredictable and vibrant nature of solar flares, perfect for artists and creators seeking a burst of fiery inspiration."
]

(1..10).each do |i|
  entry = ContestEntry.create!(
    potion_name: titles[i-1],
    description: summaries[i-1],
    contest: contest1,
    user: user3
  )
  entry_image_path = Rails.root.join('app', 'assets', 'images', 'Contest Submisions', 'Flame_Sub_%d.png' % [i])
  entry.image.attach(io: File.open(entry_image_path), filename: 'Flame_Sub_%d.png' % [i])
end

# Add any other seed data (e.g., potions, categories, etc.)