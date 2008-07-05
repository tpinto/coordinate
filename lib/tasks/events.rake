namespace :event do
	desc 'Create the Event object'

	task :create => :environment do
	  Event.create :name => ENV['NAME'], :description => ENV['DESC'], :alias => ENV['ALIAS']
	end
end