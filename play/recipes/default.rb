bash "setup-iptables" do
    user "root"
    code <<-EOH
    sudo dd if=/dev/zero of=/home/swapfile bs=1M count=2048 &&
    sudo chmod 600 /home/swapfile &&
    sudo mkswap /home/swapfile &&
    echo /home/swapfile none swap defaults 0 0 | sudo tee -a /etc/fstab &&
    sudo swapon -a
    iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to 9000
    EOH
  end
