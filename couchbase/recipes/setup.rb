#install couchbase remote file

Chef::Log.info("couchbase remote installation start")



#install alertlogic log agent
remote_file "/tmp/couchbase.deb" do
 source "http://packages.couchbase.com/releases/3.0.1/couchbase-server-community_3.0.1-ubuntu12.04_amd64.deb"
 owner 'root'
 group 'root'
 mode '0644'
end
##
package "couchbase-server-community_3.0.1-ubuntu12.04_amd64.deb" do
 provider Chef::Provider::Package::Dpkg
 source "/tmp/couchbase.deb"
 action :install
end


Chef::Log.info("couchbase remote installation completed")
