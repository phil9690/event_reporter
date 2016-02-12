namespace :report do
  desc "Daily Events"
  task :daily_reports => :environment do
    Report.daily_report.deliver_now
  end
end
