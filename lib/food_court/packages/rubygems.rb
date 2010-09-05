package :rubygems do
  description 'Ruby Gems'
  version '1.3.7'
  source "http://rubyforge.org/frs/download.php/70696/rubygems-1.3.7.tgz" do
    pre :install, 'echo "gem: --no-rdoc --no-ri" >> /etc/gemrc;'
    custom_install 'ruby setup.rb'
    post :install, "ln -nf /usr/bin/gem1.8 /usr/bin/gem"
    post :install, 'gem sources -a http://gems.opscode.com'
    post :install, 'gem update'
    post :install, "gem update --system"
  end

  requires :ruby
end
