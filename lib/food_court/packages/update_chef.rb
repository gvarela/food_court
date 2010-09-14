
packager = FoodCourt::Packager.new()
packager.configure
deploy_dir = packager.compile


package :run_chef_solo do
  noop do
    pre :install, 'chef-solo -c /etc/chef/solo.rb -j /etc/chef/dna.json'
  end
end

package :update_dna_config do
  transfer "#{deploy_dir}/dna.json", '/tmp/dna.json' do
    post :install, 'mv /tmp/dna.json /etc/chef/dna.json'
  end
  transfer "#{deploy_dir}/solo.rb", '/tmp/solo.rb' do
    post :install, 'mv /tmp/solo.rb /etc/chef/solo.rb'
  end

  transfer "#{deploy_dir}/site-cookbooks.tar.gz", "/tmp/site-cookbooks.tar.gz" do
    pre :install, "mkdir -p /var/chef"
    pre :install, "rm -rf #{packager.config[:file_cache_path]}/site-cookbooks"
    post :install, "tar -zxvf /tmp/site-cookbooks.tar.gz -C #{packager.config[:file_cache_path]}"
  end
  
end

package :update_cookbooks do
  noop do
    packager.config[:cookbooks].each do |book, path|
      cookbook_path = "#{packager.config[:file_cache_path]}/#{book}"
      pre :install, "rm -rf #{cookbook_path}"
      pre :install, "mkdir -p #{cookbook_path}"
      pre :install, "wget -O #{packager.config[:file_cache_path]}/#{book}.tar.gz #{path}"
      pre :install, "tar zxvf #{packager.config[:file_cache_path]}/#{book}.tar.gz --strip-components=1 -C #{cookbook_path}" 
    end
  end
end

package :update_chef do
  requires :update_dna_config
  requires :update_cookbooks
  requires :run_chef_solo
end
