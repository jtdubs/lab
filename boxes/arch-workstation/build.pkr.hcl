variables {
  boot_wait = "5s"
  shutdown_command = "sudo systemctl poweroff -i"
  base_image = "arch-interactive-xorg"
}

build {
  sources = [
    "source.hyperv-vmcx.default",
    "source.virtualbox-ovf.default",
    "source.vmware-vmx.default"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}