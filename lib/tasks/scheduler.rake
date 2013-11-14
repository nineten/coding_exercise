desc "Update likes task called by Heroku scheduler addon"
task :update_likes => :environment do
	puts "Updating likes..."
		Business.all.each(&:update_likes)
	puts "done."
end