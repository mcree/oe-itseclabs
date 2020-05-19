# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install vagrant-disksize to allow resizing the vagrant box disk.
unless Vagrant.has_plugin?("vagrant-disksize")
    raise  Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is missing. Please install it using 'vagrant plugin install vagrant-disksize' and rerun 'vagrant up'"
end

unless Vagrant.has_plugin?("vagrant-vbguest")
    raise  Vagrant::Errors::VagrantError.new, "vagrant-vbguest plugin is missing. Please install it using 'vagrant plugin install vagrant-vbguest' and rerun 'vagrant up'"
end

Vagrant.configure("2") do |config|

  config.winrm.timeout = 120
  config.winrm.retry_limit = 100

  # FW
  config.vm.define :fw do |fw|
    fw.vm.box = "mcree/opnsense"

    fw.vm.provider 'virtualbox' do |vb|
      vb.memory = 512
      vb.cpus = 1
      vb.gui = true # want gui for testing
      #vb.customize ['modifyvm', :id, '--nic1', 'nat'] # don't touch this interface!

      # Setup firewall port assignments
      vb.customize ['modifyvm', :id, '--nic2', 'intnet']
      vb.customize ['modifyvm', :id, '--intnet2', 'ITSEC-LAN']
      vb.customize ['modifyvm', :id, '--nic3', 'intnet']
      vb.customize ['modifyvm', :id, '--intnet3', 'ITSEC-WAN']
      vb.customize ['modifyvm', :id, '--nic4', 'none']
    end

    fw.vm.synced_folder '.', '/vagrant', disabled: true

    fw.vm.network :forwarded_port, guest: 22, host: 10022, id: "ssh", auto_correct: true
    fw.vm.network :forwarded_port, guest: 443, host: 10443, auto_correct: true

    fw.vm.provision "file", source: "fw/FW-config.xml", destination: "/conf/config.xml" # copy default config to firewall
    fw.vm.provision "shell", inline: "opnsense-shell reload" # apply configuration
  end

  # WIN
  config.vm.define :win do |win|
    win.vm.box = "mcree/win2019"
    win.vm.provider 'virtualbox' do |vb|
      vb.memory = 2048
      vb.cpus = 2
      vb.gui = true # want gui for testing
    end

    win.vm.synced_folder '.', '/vagrant', disabled: true
    win.vm.boot_timeout = 1200

    # Network port assignment
    win.vm.network "private_network", ip: "172.16.2.254", virtualbox__intnet: "ITSEC-LAN"

    win.vm.provision "file", source: "win/hosts", destination: "C:\\Windows\\System32\\drivers\\etc\\hosts"

    # Prefer routing on the private network (increase metric of Vagrant's default NAT interface)
    win.vm.provision "shell", inline: <<-'SCRIPT'
        choco install --yes --no-progress sysinternals firefox nmap wireshark kitty

        $wshshell = New-Object -ComObject WScript.Shell
        $lnk = $wshshell.CreateShortcut("C:\\Users\\Public\\Desktop\\Sysinternals.lnk")
        $lnk.WindowStyle = 1
        $lnk.TargetPath = "explorer.exe"
        $lnk.Arguments = 'C:\ProgramData\chocolatey\lib\sysinternals\tools'
        $lnk.IconLocation = "explorer.exe,0"
        $lnk.Save()

        $lnk = $wshshell.CreateShortcut("C:\\Users\\Public\\Desktop\\Zenmap.lnk")
        $lnk.TargetPath = 'C:\Program Files (x86)\Nmap\zenmap.exe'
        $lnk.Save()

        $lnk = $wshshell.CreateShortcut("C:\\Users\\Public\\Desktop\\Wireshark.lnk")
        $lnk.TargetPath = 'C:\Program Files\Wireshark\Wireshark.exe'
        $lnk.Save()

        $lnk = $wshshell.CreateShortcut("C:\\Users\\Public\\Desktop\\Kitty.lnk")
        $lnk.TargetPath = 'C:\ProgramData\chocolatey\lib\kitty\tools\kitty.exe'
        $lnk.Save()

        $lnk = $wshshell.CreateShortcut("C:\\Users\\Public\\Desktop\\KittyGen.lnk")
        $lnk.TargetPath = 'C:\ProgramData\chocolatey\lib\kitty\tools\kittygen.exe'
        $lnk.Save()

        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        Install-ADDSForest -DomainName itseclabs.local -Force -NoRebootOnCompletion -SafeModeAdministratorPassword (ConvertTo-SecureString "Hallgato1234." -Force -AsPlainText)

        Get-NetIPInterface -InterfaceAlias Ethernet | Set-NetIPInterface -InterfaceMetric 2000 -AdvertiseDefaultRoute Disabled -Forwarding Disabled -RouterDiscovery Disabled -IgnoreDefaultRoutes Enabled
        route /p add 0.0.0.0 MASK 0.0.0.0 172.16.2.1

        shutdown /r /c "Provision done."
    SCRIPT
  end

  # Linux BASE
  config.vm.define :lin do |lin|
    lin.vm.box = "ubuntu/bionic64"

    lin.disksize.size = '20GB'

    lin.vm.provider "virtualbox" do |vb|
       # Display the VirtualBox GUI when booting the machine
       vb.gui = true
       # Customize the amount of memory on the VM:
       vb.memory = "4096" # 4G
       vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
    end

    lin.vm.provision "shell", inline: <<-SHELL
      DEBIAN_FRONTEND=noninteractive apt-get -y install python3 python3-distutils
      update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10
    SHELL

    lin.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.become = true
      ansible.compatibility_mode = "2.0"
      ansible.version = "2.9.4"
      ansible.install = true
      ansible.install_mode = "pip"
    end

    lin.vm.network "private_network", ip: "172.16.1.254", virtualbox__intnet: "ITSEC-WAN"
  end

end
