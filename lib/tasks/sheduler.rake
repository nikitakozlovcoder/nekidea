desc 'updating votes'
task :update_votes => :environment do
  Vote.all.each{|v| v.update_iteration}
end
