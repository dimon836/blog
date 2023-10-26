# frozen_string_literal: true

desc 'Converting data from string to integer for statuses'

namespace :status_type do
  task :convert_string_status_to_integer, [:model_names] => :environment do |_t, args|
    puts 'STARTED convert_string_status_to_integer RAKE TASK FOR MODELS: '
    (args[:model_names]).each do |model|
      puts " #{model} model"

      model.statuses.each do |key, value|
        model.where(old_status: key).in_batches.update_all(status: value)
      end
    end
    puts 'FINISHED'
  end

  task :convert_integer_status_to_string, [:model_names] => :environment do |_t, args|
    puts 'STARTED convert_integer_status_to_string RAKE TASK FOR MODELS: '
    (args[:model_names]).each do |model|
      puts " #{model} model"

      model.statuses.each do |key, value|
        model.where(status: value).in_batches.update_all(old_status: key)
      end
    end
    puts 'FINISHED'
  end
end
