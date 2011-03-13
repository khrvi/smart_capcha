require 'digest/sha2'
require 'questionnaire'
require 'smart_capcha_helper'
module SmartCapcha
  module Controller

    def self.included(obj)
      obj.helper_method :captcha_passed?, :prepare_capcha_question
      obj.helper SmartCapcha::Helper
    end

    def valid_smart_capcha?
      return captcha_failure unless params[:captcha_answer]
      captcha_passed? ? true : captcha_failure
    end

    def prepare_capcha_question
      result = Questionnaire.find_random_question
      session[:captcha_status] = encrypt(result.last)
      result.first
    end

    def captcha_passed?
      session[:captcha_status] == encrypt(params[:captcha_answer])
    end

    def captcha_failure
      flash[:capcha_error] = Questionnaire.config[:failure_message]
      false
    end

    private

    def encrypt(answer)
      Digest::SHA512.hexdigest("--#{answer}--#{Questionnaire.config[:salt]}--")
    end
  end
end
ActionController::Base.send :include, SmartCapcha::Controller