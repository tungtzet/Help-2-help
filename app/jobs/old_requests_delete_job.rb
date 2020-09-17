class OldRequestsDeleteJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    puts "Delete olds Friendship"
    Friendship.where(status: "pending").where("created_at < ?", 2.week.ago).delete_all
    puts "Done"
  end
end
