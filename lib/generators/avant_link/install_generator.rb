class AvantLinkRailtie < Rails::Generators::Base
  source_root(File.expand_path(File.dirname(__FILE__))
  def copy_initializer
    copy_file 'twitter_credentials.rb', 'config/initializers/twitter_credentials.rb'
  end
end