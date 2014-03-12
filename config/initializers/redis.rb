uri = URI.parse(Rails.env.development? ? "redis://127.0.0.1:6379" : ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
