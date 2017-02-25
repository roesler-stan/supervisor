# Add the celery log folder
directory node['celery']['log_directory'] do
  owner node[:user]
  group node[:group]
  mode 0766
end

supervisor_service "celery1" do
  action [:enable, :start, :restart]
  autostart true
  autorestart "unexpected"
  user node[:user]
  directory node[:celery][:workdir]
  command "/usr/local/bin/celery -A #{node[:celery][:project]} worker -l #{node[:celery][:log_level]} -Q high -n worker1"
  stdout_logfile "/var/log/celery/worker.log"
  stderr_logfile "/var/log/celery/worker.log"
end

supervisor_service "celery2" do
  action [:enable, :start, :restart]
  autostart true
  autorestart "unexpected"
  user node[:user]
  directory node[:celery][:workdir]
  command "/usr/local/bin/celery -A #{node[:celery][:project]} worker -l #{node[:celery][:log_level]} -Q high,default -n worker2"
  stdout_logfile "/var/log/celery/worker.log"
  stderr_logfile "/var/log/celery/worker.log"
end