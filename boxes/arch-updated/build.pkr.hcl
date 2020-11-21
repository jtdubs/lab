variables {
  boot_wait = "5s"
  shutdown_command = "sudo systemctl poweroff -i"
  base_image = "arch-base"
}

build {
  sources = [
    "source.hyperv-vmcx.default",
    "source.virtualbox-ovf.default",
    "source.vmware-vmx.default"
  ]

  provisioner "shell" {
    execute_command = "sudo bash '{{ .Path }}'"
    script          = "scripts/update.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}