require "redis"
require "pg"

def log(message)
  puts "\e[34m#{message}\e[0m"
end

log "Checking Redis server..."
redis = Redis.new()
log "REDIS VERSION: #{redis.info["redis_version"]}"

sleep 2

log "Checking PostgreSQL server..."
pg = PG.connect({
  host: ENV['POSTGRES_HOST'],
  dbname: ENV['POSTGRES_DB'],
  user: ENV['POSTGRES_USER']
  })
log pg.exec("SELECT version();").first["version"]
