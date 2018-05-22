module Distributable
  class Engine < ::Rails::Engine
    isolate_namespace Distributable

		config.to_prepare do
			# include into ApplicationController
			#ActionController::Base.send :include, Canopus::Concerns::Controllers::Authenticator
			ActiveRecord::Base.send :include, Distributable::DistributedNode
		end		
  end
end
