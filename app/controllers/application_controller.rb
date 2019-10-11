class ApplicationController < ActionController::Base

  def hello
    render html: "Hello Linksin!"
  end

end
