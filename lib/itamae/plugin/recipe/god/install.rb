gem_package 'god' do
  version '0.13.7'
  user 'root'
end

directory '/etc/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template '/etc/god/master.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

service_variables = {
  pid: '/var/run/god.pid',
  config: '/etc/god/master.conf',
  log: '/var/log/god.log',
  log_level: 'info'
}

case "#{node.platform_family}-#{node.platform_version}"
when /rhel-7\.(.*?)/
  which_god = run_command('which god')
  template '/etc/systemd/system/god.service' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
    variables service_variables.merge({command: which_god.stdout.chomp})
  end
else
  template '/etc/init.d/god' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
    variables service_variables
  end
end

template '/etc/logrotate.d/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end
