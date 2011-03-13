class QuestionnaireConfigGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates/config", __FILE__)
 
  def copy_initializer_file
    copy_file "questionnaire.yml", "config/#{file_name}.yml"
  end
end