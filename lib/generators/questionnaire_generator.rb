class QuestionnaireConfigGenerator < Rails::Generators::Base
  def create_questionnaire_file
    create_file "config/questionnaire.rb", "# Add initialization content here"
  end
end