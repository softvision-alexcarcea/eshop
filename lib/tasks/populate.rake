require 'faker'

namespace :db do
  # clear database
  Rake::Task['db:reset'].invoke
  
  desc "Populates database with generated data"
  task :populate => :environment do
    create_products
  end
end

private
  def create_products
    100.times do
      Product.create! :name => Faker::Lorem.words,
                      :description => Faker::Lorem.sentences
    end
  end
