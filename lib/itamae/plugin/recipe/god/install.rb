alt_god = ENV['ALTERNATIVE_GOD']
god_gem =
  case ::File.basename(alt_god.to_s)
  when %r!\Agod-.gem\z! then  # If package_name starts with 'god-' and ends with '.gem', then version can be extracted.
    { package: alt_god,
      version: ::File.basename(alt_god)[/god-(.+)\.gem/, 1]
    }
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

gem_package 'god' do
  package_name god_gem[:package]
  version god_gem[:version]
  options ['-N']
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

ruby_bin_dir = node.languages.ruby.bin_dir rescue nil
service_variables = {
  god_bin: (ruby_bin_dir ? "#{ruby_bin_dir}/god" : 'god'),
  pid: '/var/run/god.pid',
  config: '/etc/god/master.conf',
  log: '/var/log/god.log',
  log_level: 'info'
}

case "#{node.platform_family}-#{node.platform_version}"
when /rhel-6\.(.*?)/
  template '/etc/init.d/god' do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
    variables service_variables
  end
else
  template '/etc/systemd/system/god.service' do
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
