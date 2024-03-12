desc "This task is called by the Heroku scheduler add-on"
task :purge_conversations => :environment do
  puts "Purging empty conversations older than 24 hours..."
  Conversation.joins(:messages)
    .where('last_activity_at < ?', 24.hours.ago.utc)
    .group('conversations.id')
    .having('COUNT(messages.id) <= 5')
    .destroy_all
  
  puts "done."
end
