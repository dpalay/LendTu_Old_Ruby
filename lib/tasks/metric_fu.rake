begin  
	require 'metric_fu'  

	MetricFu::Configuration.run do |config|
        #define which metrics you want to use
        config.metrics  = [ :stats, :flog]
        config.flay     = { :dirs_to_flay => ['app', 'lib']  } 
        config.flog     = { :dirs_to_flog => ['app', 'lib']  }
        config.reek     = { :dirs_to_reek => ['app', 'lib']  }
        config.roodi    = { :dirs_to_roodi => ['app', 'lib'] }


	end  
	
rescue LoadError  
end  