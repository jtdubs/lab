source "vmware-vmx" "default" {
  network            = "vmnet8"
  output_directory   = "output-vmware"

  boot_wait        = var.boot_wait
  communicator     = var.communicator
  display_name     = basename(dirname("."))
  headless         = var.headless
  http_directory   = "${var.http_directory}/vmware"
  shutdown_command = var.shutdown_command
  source_path      = "../$(base_image)/output-vmware/$(base_image).vmx"
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = basename(dirname("."))
}