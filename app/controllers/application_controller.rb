class ApplicationController < ActionController::Base
  # sessions_helperを全てのコントローラーで使えるようにする
  protect_from_forgery with: :exception
  include SessionsHelper
end
