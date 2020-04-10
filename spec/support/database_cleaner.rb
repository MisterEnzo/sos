RSpec.configure do |config|

#   config.before(:suite) do
#   DatabaseCleaner.clean_with :truncation  # clean DB of any leftover data
#   DatabaseCleaner.strategy = :transaction # rollback transactions between each test
#   Rails.application.load_seed # (optional) seed DB
# end

# config.before(:each) do
#   DatabaseCleaner.start
# end

# config.after(:each) do
#   DatabaseCleaner.clean
# end

#####

  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  # config.around(:each) do |example|
  #   DatabaseCleaner.cleaning do
  #     example.run
  #   end
  # end

  ############

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
  end
end