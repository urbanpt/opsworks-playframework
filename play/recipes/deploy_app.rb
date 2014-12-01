include_recipe "deploy"
include_recipe "play"

# Don't deploy unless we found a Play! app
if node[:play][:app][:found]
  # Get app information
  application = node[:play][:application]
  deploy = node[:deploy][application]
  
  # Ensure Play! application has been built
  include_recipe "play::build_app"
  
  #bash "deploy-play-app-dist" do
   # code <<-EOH
    #mv #{deploy[:current_path]}/application/conf/production.conf #{deploy[:current_path]}/application/conf/application.conf
    #EOH
  #end
  
  include_recipe "play::play_app_service"
  
  # Create/update the app configuration file
  ec2Type = node[:opsworks][:instance][:instance_type]
  xms = node[:play][:jvm][:xms][ec2Type]
  xmx = node[:play][:jvm][:xmx][ec2Type]
  
  # Create/update the app executable
  template "#{node[:play][:app][:bin_path]}" do
      source 'playapp.bin.erb'
      owner 'root'
      group 'root'
      variables(
        :xms => xms,
        :xmx => xmx,
        :startscript => "play start #{deploy[:current_path]}/application"
        )
      mode '750'
      action :create
      notifies :restart, resources(:service => ['play_app']), :delayed
  end
  
  # Create/update the app's init daemon script
  template "/etc/init.d/play_app" do
      source 'play_app.service.erb'
      owner 'root'
      group 'root'
      mode '755'
      action :create
      notifies :restart, resources(:service => ['play_app']), :delayed
  end
end
