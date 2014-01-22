class LoginPage < SitePrism::Page
  set_url "http://localhost:3000"
  set_url_matcher //

  element :username, '#username'
  element :password, '#password'
  element :submit, '.btn-submit'
end
