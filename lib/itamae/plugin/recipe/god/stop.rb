service 'god' do
  user 'root'
  action [:disable, :stop]
end
