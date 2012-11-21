# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# create categories
categories_data = {
  { name: "Software", description: "A top level category" } =>
    {
      { name: "Apps", description: "A second level category" } =>
        {
          { name: "Office", description: "A third level category" } =>
            {
              { name: "Docs", description: "A fourth level category" } => nil,
              { name: "Slideshow", description: "Another fourth level category" } => nil,
              { name: "Database", description: "Yet another fourth level category" }  => nil
            }
        },
      { name: "Games", description: "Another second level category" } =>
        {
          { name: "RTS", description: "Real-time strategy games" } => nil,
          { name: "RPG", description: "Role-playing games" } => nil,
          { name: "FPS", description: "First person shooters" } => nil
        }
    },
  { name: "Hardware", description: "Another top level category" } =>
    {
      { name: "HDD", description: "Hard-disks, both internal and external" } => nil,
      { name: "Peripherals", description: "All sorts of peripherals" } => nil
    }
}

@categories = []

def create_categories(tree, parent = nil)
  tree.each do |data, subtree|
    category = parent ? parent.children.create!(data) : Category.create!(data)
    @categories.append(category)
    create_categories(subtree, category) if subtree
  end
end

create_categories(categories_data)

# create products
@products = []

@tags = ["mobile", "desktop", "new", "patch", "recommended", "sale"]

100.times do
  categories = []
  tags = []
  rand(1..3).times do
    index = rand(0...@categories.length)
    category = @categories[index]
    categories.append(category) if not categories.include?(category)
    
    index = rand(0...@tags.length)
    tag = @tags[index]
    tags.append(tag) if not tags.include?(tag)
  end
  product = Product.create! name: Faker::Lorem.words.join(" ").capitalize,
                            description: Faker::Lorem.sentences.join(" "),
                            price: rand(1..20) + 0.99,
                            categories: categories,
                            tag_list: tags
  @products.append(product)
end

# create admins
roles = {
    admin:      nil,
    editor:     Admin::ROLE_EDITOR,
    moderator:  Admin::ROLE_MODERATOR,
    super:      Admin::ROLE_SUPER
  }

roles.each do |name, role|
  Admin.create! email: "#{name}@eshop.com",
                password: "letmein",
                password_confirmation: "letmein",
                role: role
end
