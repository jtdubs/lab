source "virtualbox-ovf" "default" {
  output_directory   = "virtualbox-ovf"
  source_path      = "../$(base_image)/output-virtualbox/$(base_image).ovf"

  boot_wait        = var.boot_wait
  communicator     = var.communicator
  display_name     = basename(dirname("."))
  headless         = var.headless
  http_directory   = "${var.http_directory}/virtualbox"
  shutdown_command = var.shutdown_command
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = basename(dirname("."))
}