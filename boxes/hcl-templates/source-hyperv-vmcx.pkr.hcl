source "hyperv-vmcx" "default" {
  generation       = 2
  output_directory = "output-hyperv"
  switch_name      = "Default Switch"
  clone_from_vmcx_path = "../$(base_image)/output-hyperv"
  
  boot_wait        = var.boot_wait
  communicator     = var.communicator
  headless         = var.headless
  http_directory   = "${var.http_directory}/hyperv"
  memory           = var.memory
  shutdown_command = var.shutdown_command
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = basename(dirname("."))
}