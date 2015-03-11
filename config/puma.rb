environment "production"

daemonize true
threads 0,16
workers 2

deploy_to = '[deploy_dir]'
shared_path = '[shared_folder]'
bind       "unix://#{deploy_to}/#{shared_path}/tmp/sockets/puma.sock"
state_path        "#{deploy_to}/#{shared_path}/tmp/sockets/puma.state"
pidfile           "#{deploy_to}/#{shared_path}/tmp/pids/puma.pid"
preload_app!
activate_control_app

on_worker_boot do
  puts 'On worker boot...'
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
