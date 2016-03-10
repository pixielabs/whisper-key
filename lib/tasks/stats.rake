namespace :whisper_key do
  desc 'Print some stats about the WK environment'
  task :stats => :environment do
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    puts "Magic words:\t\t#{User.count}/#{MagicWords.size}"

    percent_used = (User.count.to_f / MagicWords.size) * 100
    puts "Used:\t\t\t#{percent_used.round(2)}%"
    

    puts "Messages:\t\t#{Message.count}"

    puts "Avg. per magic words:\t#{(Message.count.to_f / User.count).round(2)}"

    ActiveRecord::Base.logger = old_logger
  end
end
