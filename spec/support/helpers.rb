module Helpers
  def with_env(opts = {})
    old = {}
    opts.each do |k, v|
      k = k.to_s
      v = v.to_s unless v.nil?
      old[k] = ENV[k]
      ENV[k] = v
    end
    yield
  ensure
    old.each do |k, v|
      ENV[k] = v
    end
  end

  def with_rails_env(env)
    initial_env = WebValve.env
    WebValve.env = env
    yield
  ensure
    WebValve.env = initial_env
  end

  def with_allow_service_connect(value)
    initial_value = WebValve.allow_service_connect
    WebValve.allow_service_connect = value
    yield
  ensure
    WebValve.allow_service_connect = initial_value
  end
end
