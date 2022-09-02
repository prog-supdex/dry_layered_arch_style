require_relative "system/container"
require 'rom-sql'
require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    Container.start(:db)
    config = Container['db.config']
    config.gateways[:default].use_logger(Logger.new($stdout))
  end
end
