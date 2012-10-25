require "mongo"
require "bson"
require "mongo_logger/version"
require "timeout"

class MongoLogger

  COLLECTION_CAP = 2_000
  COLLECTION_SIZE_BYTES = 20_000_000
  MONGO_TIMEOUT = 0.25

  attr_accessor :logger

  def initialize(config, options = {})
    @config = config
    @logger = options[:logger]

    # Cache Mongo::Connection objects here
    @collections = {}
  end

  def log(type, data)
    Timeout.timeout(MONGO_TIMEOUT) do
      collection = get_or_create_collection(type)
      collection.insert(data)
    end

  rescue => e
    if logger
      logger.error "MongoLogger Error: #{e.message}"
      e.backtrace.each { |line| logger.error(line) }
    end

    nil
  end

  def get_or_create_collection(name)
    return @collections[name] if @collections[name]

    begin
      db.strict = true
      @collections[name] = db[name]

    rescue Mongo::MongoDBError => e
      @collections[name] = db.create_collection(
        name,
        :capped => true,
        :size => COLLECTION_SIZE_BYTES, :max => COLLECTION_CAP
      )

    ensure
      db.strict = false
    end

    @collections[name]
  end

  def connection
    @connection ||= Mongo::Connection.new(@config[:host], @config[:port])
  end

  def db
    @db ||= connection.db(@config[:database])
  end
end

