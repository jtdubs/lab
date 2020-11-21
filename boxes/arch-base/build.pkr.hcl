variables {
  iso_urls = [
    "iso/archlinux-2020.11.01-x86_64.iso",
    "http://mirrors.mit.edu/archlinux/iso/2020.11.01/archlinux-2020.11.01-x86_64.iso"
  ]
  iso_checksum = "sha1:739fab8d23430a01629a131ae02713a09af86968"
}

variables {
  shutdown_command = "sudo systemctl poweroff -i"
}

build {
  source "source.vmware-iso.default" {
    boot_command = [
      "<enter><wait40>",
      "curl ${build.PackerHTTPAddr}/enable-ssh.sh | bash<enter>"
    ]
    boot_wait = "5s"
  }

  source "source.virtualbox-iso.default" {
    boot_command = [
      "<enter><wait40>",
      "curl ${build.PackerHTTPAddr}/enable-ssh.sh | bash<enter>"
    ]
    boot_wait = "5s"
  }
  
  source "source.hyperv-iso.default" {
    boot_command = [
      "<enter><wait40>",
      "curl ${build.PackerHTTPAddr}/enable-ssh.sh | bash<enter>"
    ]
    boot_wait = "5s"
  }

  provisioner "file" {
    destination = "/tmp/"
    sources     = [
      "../../vagrant.id_rsa.pub",
      "scripts/install.sh",
      "scripts/install-vmware.sh",
      "scripts/install-virtualbox.sh",
      "scripts/install-hyperv.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    script          = "scripts/bootstrap.sh"
  }

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    only            = ["source.vmware-iso.default"]
    script          = "scripts/bootstrap-vmware.sh"
  }

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    only            = ["source.virtualbox-iso.default"]
    script          = "scripts/bootstrap-virtualbox.sh"
  }

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    only            = ["source.hyperv-iso.default"]
    script          = "scripts/bootstrap-hyperv.sh"
  }

  provisioner "shell" {
    inline = ["sudo systemd-nspawn --machine=guest -D /mnt /install.sh"]
  }

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }
}