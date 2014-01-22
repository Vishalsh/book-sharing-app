module CommonSteps
	module LoadApplication
    include Spinach::DSL

    def load_app
    @app = App.new
  	end

  	# def login user
  	# 	CASClient::Frameworks::Rails::Filter.fake("default")
  	# end
  end
end