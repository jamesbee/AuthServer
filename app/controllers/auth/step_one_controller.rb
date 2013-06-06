require 'securerandom'

class Auth::StepOneController < ApplicationController

  def login
    @user = Auth::Person.authenticate(params[:email],params[:password])
    unless @user.nil?
      challange = SecureRandom.hex
      @user = Auth::Person.find_by_email @user.email
      @user.auth_token = challange
      unless @user.save
        logger.error "Cant save user!"
      end

      respond_to do |format|
        format.xml { render partial: "auth/step_one/response",
                            :locals => {:granted => true, :challange => challange} }
      end
    else
      respond_to do |f|
        f.xml {render partial: "auth/step_one/response", :locals => {:granted => false, :challange => "NULL" }}
      end
    end

  end

end
