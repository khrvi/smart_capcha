module SmartCapcha
  module Helper
    def smart_capcha
      result = ''
      result << "<span id='smart_capcha'>"
      result << "<label for='captcha_answer'>"
      result << "#{Questionnaire.config[:label_text]} #{prepare_capcha_question}</label>"
      result << text_field_tag(:captcha_answer, params[:captcha_answer], :size => 30)
      result << "</span>"
      result.html_safe
    end
  end
end
