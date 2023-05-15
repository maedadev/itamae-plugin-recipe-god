alt_god = ENV['ALTERNATIVE_GOD']
god_gem =
  case alt_god
  when %r!\.gem\z! then  # Ends with '.gem'
    { package: alt_god,
      version: nil
    }
  when %r!\A\S+\z! then  # Matches characters without white spaces
    { package: alt_god,
      version: ENV['ALTERNATIVE_GOD_VERSION']
    }
  else
    { package: 'god',
      version: '0.13.7'
    }
  end

# if rbenv is not installed or rbenv points to system ruby, then we consider that sudo is required.
require_sudo = ! system("which rbenv > /dev/null 2>&1 && rbenv version | grep -vq '^system$'")


gem_package 'god' do
  package_name god_gem[:package]
  version god_gem[:version]
  user 'root' if require_sudo
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
  template '/etc/systemd/system/god.service' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
    variables service_variables
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
