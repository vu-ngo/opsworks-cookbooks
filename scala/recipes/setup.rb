include_recipe 'apt'

#install Scala remote file

Chef::Log.info("scala remote installation start")
# install OpenJDK in either case to satisfy package dependencies
package "scala" do
action :install
end

Chef::Log.info("scala remote installation completed")
Chef::Log.info("setup java ppa")
apt_repository 'java' do
  uri          'ppa:webupd8team/java'
  distribution node['lsb']['codename']
end

Chef::Log.info("setup java ppc Completed")


Chef::Log.info("accept java EULA")
ruby_block 'reload_client_config' do
  block do
	accept_license = Mixlib::ShellOut.new('echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections')

	accept_license_value = accept_license.run_command.stdout.to_str
	accept_license.error!
	Chef::Log.info("accept_license with value: #{accept_license_value}")
  end
  action :create
end

Chef::Log.info("finish accepting java eula")

Chef::Log.info("install java software")
apt_package 'oracle-java8-installer'

apt_package 'oracle-java8-set-default'
Chef::Log.info("finish java software")

