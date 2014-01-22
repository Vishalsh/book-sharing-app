class Spinach::Features::Login < Spinach::FeatureSteps     
	include CommonSteps::LoadApplication

 step 'Default user is logged in' do
    	load_app
    	@app.login_page.load
    	@app.login_page.username.set "#{username}"
    	@app.login_page.password.set "#{password}"
    	@app.login_page.submit.click
 end

 step 'logged in user can view the home page' do
 	@app.home_page.username.text == "#{username}"
 end

end