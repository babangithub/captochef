load './config/deploy/develop.rb'

namespace :chef do
                # ユーザ名指定
                user = 'chefuser'

                # パスワード指定
                password = 'password'
	desc "chef install"
	task :init do
		on roles(:client) do
			execute "ls -a"
		end
	end
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
end

