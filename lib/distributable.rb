require "distributable/engine"
require 'securerandom'

module Distributable
	module DistributedNode
		extend ActiveSupport::Concern

		included do
		end

		module ClassMethods
			# 
			# this install the logic and kick started the operation
			# 
			def distributable(opts = {})
				options = {
					dist_key: :identifier,
					skipped: %w(created_at updated_at created_by updated_by id),
					change_log_table: "change_logs",
					sync_log_table: "sync_ogs",
					log: Logger.new(STDOUT)
				}

				options.merge!(opts)

				self.primary_key = options[:dist_key].to_sym

				before_create :generate_identifier

				after_create :log_new
				after_update :log_update
				after_destroy :log_destroy

				#validates options[:dist_key].to_sym, uniqueness: true
				@@options = options
			end

			def options
				@@options
			end

		end

		# instance methods
		def distributed?
			true
		end

		def generate_identifier
			if self.has_attribute?(:identifier)
				while(true)
					self.identifier = SecureRandom.uuid
					cnt = eval("#{self.class.name}.where([\"identifier = ?\",'#{self.identifier}']).count")
					break if cnt == 0
				end
			else
				STDERR.puts "Identifier field does not exist in schema"
			end		
		end



		def log_new
			opts = self.class.options
			if ActiveRecord::Base.connection.table_exists?(opts[:change_log_table].to_s)
				log = eval("#{opts[:change_log_table].to_s.classify}.new")	
				log.table_name = self.class.table_name
				log.key = self.send opts[:dist_key]
				log.operation = 1
				log.save
			end
		end

		def log_update
			opts = self.class.options
			if ActiveRecord::Base.connection.table_exists?(opts[:change_log_table].to_s)
				if self.changed.length > 0
					changed = self.changed.delete_if { |c| opts[:skipped].include?(c) }
					if changed.length > 0

						log = eval("#{opts[:change_log_table].to_s.classify}.new")	
						log.table_name = self.class.table_name
						log.key = self.send opts[:dist_key]
						log.changed_fields = changed.to_yaml
						log.operation = 2
						log.save

					end
				end
			end
		end

		def log_destroy
			opts = self.class.options
			if ActiveRecord::Base.connection.table_exists?(opts[:change_log_table].to_s)
				log = eval("#{opts[:change_log_table].to_s.classify}.new")	
				log.table_name = self.class.table_name
				log.key = self.send opts[:dist_key]
				log.operation = 3
				log.save
			end
		end

	end
end
