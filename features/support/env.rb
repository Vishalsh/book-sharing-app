require 'casclient'
require 'casclient/frameworks/rails/filter'

require 'capybara'
require 'site_prism'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Spinach.hooks.before_scenario do
	#database cleaning strategy
end

Capybara.default_driver = :selenium