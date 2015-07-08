load './config/deploy/develop.rb'

namespace :os do
                # ユーザ名指定
                user = 'chefuser'

                # パスワード指定
                password = 'password'
	desc "chef install"
	task :useradd do
		# 乱数作成
		salt = rand( 36**8 ).to_s( 36 )

		# 乱数を元に暗号化
		shadow_hash = password.crypt( salt )
		on roles( :client ) do

			# ユーザ追加
			execute "useradd -p '#{shadow_hash}' #{user}"
		end
	end
	task :key_set do
		src = '/opt/capistrano/manage/files/root/.ssh/authorized_keys'
		dir = '/root/.ssh'
		dst = '/root/.ssh/tmp_keys'
		on roles(:client) do
			execute "test -d #{dir} && mkdir -p #{dir}"
			upload! src, dst, :recursive => true
			execute "cat #{dst} >> #{dir}/authorized_keys"
			execute "rm -f #{dst}"
		end
	end
end

