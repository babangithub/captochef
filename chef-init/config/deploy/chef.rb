load './config/deploy/develop.rb'

# namespaceをchefとする
namespace :chef do

	# taskをinstallとする
	task :install do
		# ②rubyソースファイルのダウンロード先、展開先設定
		src_dir = "/root/captochef/chef-init"
		src_fil = "#{src_dir}/ruby-2.2.2.tar.gz"
		dst_dir = "/root"
		shl_dir = "/root/captochef/chef-init"
		shl_fil = "#{shl_dir}/install_chef.sh"
		dst_fil = "#{dst_dir}/install_chef.sh"		
		url_ruby = "http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz"
		# capistranoを実行するサーバにて行う処理を記載する
		run_locally do
			# ③capistranoサーバにてwgetコマンドを使用してダウンロード
                        execute "wget #{url_ruby}"
		end
		# ④roleがclient(./config/deploy/develop.rbに定義)に対して実行
		on roles(:client) do

			# ⑤ダウンロードしたrubyソースを各サーバにアップロード 
			upload! src_fil, dst_dir, :recursive => true

			# ⑥chef(rubyを含む)のインストールシェルを各サーバにアップロード
			upload! shl_fil, dst_dir, :recursive => true

			# ⑦各サーバにてそれぞれシェルを実行 
			execute "sh #{dst_fil}"
		end
	end
end

