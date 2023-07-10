RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  rescue NoMethodError => e
    next puts("Warning: catch #{e.message}") if e.message == %(undefined method `rollback' for nil:NilClass (DB Cleaner gem))
    raise e
  end
end
