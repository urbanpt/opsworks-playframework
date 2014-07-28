bash "setup-iptables" do
    user "root"
    code <<-EOH
    iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to 9000
    EOH
  end