desc "This task is called by the Heroku scheduler add-on"
task :delete_pending_requests => :environment do
  puts "Delete old pending friendship requests..."
  OldRequestsDeleteJob.perform_later
  puts "done."
end