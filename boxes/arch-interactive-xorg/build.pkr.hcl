variables {
  boot_wait = "5s"
  shutdown_command = "sudo systemctl poweroff -i"
  base_image = "arch-updated"
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

  provisioner "shell" {
    only = ["vmware-vmx"]
    script = "scripts/setup-vmware.sh"
  }

  provisioner "shell" {
    only = ["hyeprv-vmcx"]
    script = "scripts/setup-hyperv.sh"
  }

  provisioner "shell-local" {
    only = ["hyeprv-vmcx"]
    inline = [
      "powershell.exe Set-VM -VMName {{ user `vm_name` }} -EnhancedSessionTransportType HvSocket"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}