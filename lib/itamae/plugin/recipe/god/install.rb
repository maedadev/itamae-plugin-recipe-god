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

template '/etc/init.d/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

template '/etc/logrotate.d/god' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end
