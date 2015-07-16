# AWS notes

* Deployment: http://docs.aws.amazon.com/amazonswf/latest/awsrbflowguide/hello-opsworks.html

* Public key pair: http://docs.aws.amazon.com/cli/latest/reference/ec2/import-key-pair.html

* Location on server /srv/www/channlr/current

***

# Set up nix box

* sudo yum install git

* sudo yum install postgresql

* sudo yum install gcc

* sudo yum install libxml2

* Install rbenv

    - git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

    - git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    - echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile

    - echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

    - rbenv global 2.1.0

* rbenv install 2.1.0

* sudo gem install rake

* sudo gem install bundler

* sudo gem install io-console

* Install nokugiri

    - wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz

    - tar -xvzf libiconv-1.11.tar.gz

    - cd libiconv-1.11

    - ./configure --prefix=/usr/local/libiconv

    - make CFLAGS="-O2 -fno-tree-dce -fno-optimize-sibling-calls"

    - sudo make install

    - CFLAGS="-O2 -fno-tree-dce -fno-optimize-sibling-calls" gem install nokogiri -- --with-iconv-dir=/usr/local/libiconv --with-iconv-lib=/usr/local/libiconv/lib --with-iconv-include=/usr/local/libiconv/include

* Git clone repo

* CD repo

* Install gems bundle
