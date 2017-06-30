set :output, "./cron_log.log"

every 2.hours do
  command "ruby tracker.rb"
end
