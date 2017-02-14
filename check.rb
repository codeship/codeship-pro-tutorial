require "redis"
require "pg"

def log(message)
  puts "\e[34m#{message}\e[0m"
end

log "Checking Redis server..."
begin
  redis = Redis.new()
  redis.ping
  log "REDIS VERSION: #{redis.info["redis_version"]}"
rescue Redis::CannotConnectError => e
  STDERR.puts(e.message)
  exit 1
end

log "Checking PostgreSQL server..."
begin
  pg = PG.connect({
    host: ENV['POSTGRES_HOST'],
    dbname: ENV['POSTGRES_DB'],
    user: ENV['POSTGRES_USER'],
    })
  log pg.exec("SELECT version();").first["version"]
rescue PG::Error => e
  STDERR.puts("PostgreSQL connection failed")
  exit 2
end
