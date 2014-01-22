class HomePage < SitePrism::Page
  set_url "/"
  set_url_matcher //

  element :username, '.username'
end
