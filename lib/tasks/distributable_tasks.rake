# desc "Explaining what the task does"
# task :distributable do
#   # Task goes here
# end

namespace "distributable" do
	desc "Setup the environment for distributable to work"
	task :setup do
		#out = Thread.new do
			# create change log table
			STDOUT.puts `rails g model change_log table_name:string key:string operation:integer changed_fields:text`
			STDOUT.flush
			STDOUT.puts "Distributable based model generated..."
			STDOUT.flush
			STDOUT.puts `rails db:migrate`
			STDOUT.flush
		#end

		#i = Thread.new do
		#	$stdin.each_line do |l|
		#		STDOUT.puts l
		#	end
		#end

		# createh sync log table
		#sl = `rails g model sync_log node_id:string user_id:string`
	end
end
