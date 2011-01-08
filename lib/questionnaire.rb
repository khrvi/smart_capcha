require 'humane_integer'

 # Simple model to hold sets of questions and answers.
class Questionnaire

  def self.config
    @@config ||= begin
                   file = File.join(Rails.root, "config/questionnaire.yml")
                   YAML::load(File.open(file))
                 end
  rescue
    raise "Config file is not found. Please use 'rails g questionnaire_config'."
  end

  def self.find_random_question
    questions = config['questions']['en']#[I18n.locale.to_s]
    q = questions.keys[rand(questions.size)].dup
    interval = (config['interval'] || 50).to_i
    formula = questions[q].dup
    first_number = rand(interval)
    last_number = rand(interval)
    formula.gsub!('$1', first_number.to_s)
    formula.gsub!('$2', last_number.to_s)
    result = eval(formula)
    q.gsub!('$1', HumaneInteger.new(first_number).to_english)
    q.gsub!('$2', HumaneInteger.new(last_number).to_english)
    [q, result]
  end
end