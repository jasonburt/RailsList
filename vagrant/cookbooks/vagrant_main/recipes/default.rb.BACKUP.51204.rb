include_recipe "apt"
include_recipe "postgresql::apt_postgresql_ppa"

execute "initial-sudo-apt-get-update" do
  command "sudo apt-get update"
end

execute "install python-software-properties" do
  command "sudo apt-get install --assume-yes python-software-properties"
end

node['build_essential']['compiletime'] = true
include_recipe "build-essential"
<<<<<<< HEAD

=======
>>>>>>> 5a70cd45774249543f7c616e53a4c120068eba94
include_recipe "openssl"
include_recipe "git"

node.set[:postgresql][:version] = "9.1"
node.set[:postgresql][:password][:postgres] = "root"
node.set[:postgresql][:listen_addresses] = "*"
node.set[:postgresql][:ssl] = false
node.set[:postgresql][:hba] = [
  { :method => "trust", :address => "0.0.0.0/0" },
  { :method => "trust", :address => "::1/0" },
]
node.set[:postgresql][:dir] = "/etc/postgresql/#{node[:postgresql][:version]}/main"
node.set[:postgresql][:setup_items] = ["vagrant"]

include_recipe "postgresql::apt_postgresql_ppa"
include_recipe "postgresql::server"
include_recipe "postgresql::setup"

node.set['rvm']['vagrant']['system_chef_solo'] = '/opt/vagrant_ruby/bin/chef-solo'
include_recipe "rvm::system"
include_recipe "rvm::vagrant"

=begin
ruby_default_version = 'ruby-1.9.2-p320'
include_recipe "rvm::ruby_192"

group "rvm" do
  members ["vagrant"]
  append  true
end

bash "make #{ruby_default_version} the default ruby" do
	code <<-EOH
		source /etc/profile.d/rvm.sh
		source /usr/local/rvm/scripts/rvm
		rvm --default use #{ruby_default_version}
	EOH
end

ohai "reload" do
  action :reload
end
=end
system("ruby -v")
=begin
execute "install bundler" do
  command "gem install bundler"
end
=end

rvm_shell "run bundler" do
  ruby_string "#{node['rvm']['default_ruby']}"
  cwd         "/vagrant"
  code        "bundle install"
end

rvm_shell "start server" do
  ruby_string "#{node['rvm']['default_ruby']}"
  cwd         "/vagrant/script"
  code        "rails server -d -e development"
end

=begin
execute "run bundler" do
  command "cd /vagrant && bundle install"
end

execute "start server" do
  command "cd /vagrant/script && rails server -e development"
end
=end