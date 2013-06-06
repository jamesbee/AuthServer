require 'base64'
require 'openssl'

class Auth::StepTwoController < ApplicationController

  # step_two confirm with hmac encrypted base64 string
  def confirmation

    # auth_resp: hmac encrypted byte base64 endcoding string
    #   if the length is min then 28, then return from proc
    auth_resp = params[:auth_resp].to_s.chomp
    unless auth_resp.length == 28
      render_xml false
      return
    end

    # First you should get key from db by email
    key = Auth::Person.find_by_email(params[:email]).auth_token
    #key = "cjtauqfrp25j6zglut6se7dewlmceppu"

    # Prepare auth_reso in case the '+' not appare at url
    tokens = auth_resp.split(' ').to_a
    if tokens.size == 2
        auth_resp = tokens[0] + '+' + tokens[1]
    end

    # Then send response to client if granted
    logger.debug key
    if auth_resp.to_s.eql? totp(key).to_s
      render_xml true, session_id: key
    else
      render_xml false
    end

  end

  #TODO: step_two confirm with hmac encrypted PIN
  #def confirm_with_PIN
  #
  #end

  private

  def render_xml(granted, param={})
    if granted
      logger.debug "granted"
      respond_to do |format|
        format.xml { render partial: 'auth/step_two/response', :locals => {
            granted: true,
            sed: param[:session_id]} }
      end
    else
      respond_to do |format|
        logger.debug"failed"
        format.xml { render partial: 'auth/step_two/response', :locals => {
            granted: false,
            sed: ""} }
      end
    end
  end

  # TOTP with provid key, time step with 30
  # @param key: base32 encoded hexstring
  # @return hmac; base64 encoded string
  def totp(key)
    time = Time.now.utc.to_i/30
    hmac = OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        key,
        time.to_s
    )
    logger.debug ("hmaced: " + Base64::encode64(hmac))
    Base64::encode64(hmac).chomp
  end
end
