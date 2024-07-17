echo "\n 1.パッケージのアップデートしました\n"
sudo yum update -y

echo "\n 2.PHPのパッケージをすべてアンインストールしました\n "
sudo yum -y remove php-*

echo "\n 3.amazon-linux-extrasをアップデートしました\n "
sudo yum update -y amazon-linux-extras

echo  "\n 4.amazon-linux-extrasで使用中のパッケージと使えるパッケージを確認\n "
amazon-linux-extras

echo  "\n 5.lamp-mariadb10.2-php7.2を使用停止しました\n "
sudo amazon-linux-extras disable lamp-mariadb10.2-php7.2

echo  "\n 6.PHP8.1を有効化しました\n "
sudo amazon-linux-extras enable php8.1

echo  "\n 7-1.インストールするパッケージの案内があったので、表示されたコマンドを実行しました\n "
yes | sudo yum clean metadata

echo  "\n 7-2.インストールするパッケージの案内があったので、表示されたコマンドを実行しました\n "
yes | sudo yum install php-cli php-common php-json php-devel php-fpm php-gd php-mysqlnd php-mbstring php-pdo php-xml

echo  "\n 8-1.apacheなどを再起動しました\n "
yes | sudo systemctl restart httpd.service

echo  "\n 8-2.apacheなどを再起動しました\n "
yes | sudo systemctl restart php-fpm.service

echo  "\n 9.xdebugの設定を再度インストールしました\n "
yes | sudo yum install php-pear php-devel
yes | sudo pecl uninstall xdebug
yes | sudo pecl install xdebug

echo  "\n 1.MariaDBデフォルト確認しました\n "
sudo yum list installed | grep mariadb

echo  "\n 2.MariaDBのインストールしました\n "
sudo amazon-linux-extras install mariadb10.5 -y

echo  "\n 3.Apache, MariaDBの起動しましたここで細かいチェック入ります\n "
sudo systemctl start mariadb
sudo mysql_secure_installation

echo  "\n 4-2.MaridaDBの自動起動を有効化しました\n "
sudo systemctl enable mariadb
sudo systemctl is-enabled mariadb

echo  "\n 5-1. Composerインストール（バージョン指定）しました\n "
curl -sS https://getcomposer.org/installer | php -- --version=2.3.5

echo  "\n 5-2. Composerのパスを通しました\n "
sudo mv composer.phar /usr/bin/composer

echo  "\n 5-3. Composerインストールできたかチェックしました\n "
composer

echo  "\n 6-1. Laravelプロジェクトをバージョン10指定で作成します\n "
composer create-project "laravel/laravel=10.*" cms
# composer create-project --prefer-dist laravel/laravel cms dev-master #10


echo  "\n 6-2. phpMyAdminを作成する為にディレクトリ移動\n "
cd cms

echo  "\n 7-1. コンポーザーをアップデートしました\n "
yes | sudo composer update

echo  "\n 7-2. phpMyAdminを作成する為にディレクトリ移動\n "
cd public

echo  "\n 7-3. phpMyAdminをダウンロード\n "
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.2/phpMyAdmin-5.1.2-all-languages.zip

echo  "\n 7-4. phpMyAdminを解凍\n "
unzip phpMyAdmin-5.1.2-all-languages.zip

echo  "\n 7-5. phpMyAdminのファイル名変更\n "
mv phpMyAdmin-5.1.2-all-languages phpMyAdmin

echo  "\n 7-6. cms階層に戻る\n "
cd ..

echo  "\n 7-7. セットアップファイルの削除\n "
rm setup.sh
