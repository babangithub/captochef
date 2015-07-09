load './config/deploy/develop.rb'

namespace :chef do
	task :ruby do
		src_dir = "/root/captochef/chef-init"
		src_fil = "#{src_dir}/ruby-2.2.2.tar.gz"
		dst_dir = "/root"
		shl_dir = "
		shl_fil = "#{shl_dir}/install_chef.sh"
		
		url_ruby = "http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz"
		run_locally do
                        execute "wget #{url_ruby}"
		end
		on roles(:client) do
			upload! src_dir, dst_dir, :recursive => true
			upload! shl_dir, dst_dir, :recursive => true
			execute "sh #{shl_fil}"
		end
	end
end

