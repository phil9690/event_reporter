require 'csv'

namespace :employees do

  desc "Insert users"
  task :insert_users => :environment do
    puts "Inserting users..."
    CSV.foreach("/home/phil/user_list.csv", :headers => true) do |row|
      User.create!(row.to_hash)
    end
  end


  desc "Insert employees"
  task :insert_employees => :environment do
    puts "Inserting employees..."
    CSV.foreach("/home/phil/employee_list.csv", :headers => true) do |row|
      Employee.create!(row.to_hash)
    end
  end

  desc "Insert events"
  task :insert_events => :environment do
    puts "Inserting events..."
    CSV.foreach("/home/phil/event_list.csv", :headers => true, :encoding => 'ISO-8859-1') do |row|
      Event.create!(row.to_hash)
    end
  end

end
