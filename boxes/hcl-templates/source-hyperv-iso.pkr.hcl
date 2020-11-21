source "hyperv-iso" "default" {
  generation       = 2
  output_directory = "output-hyperv"
  switch_name      = "Default Switch"
  
  communicator     = var.communicator
  cpus             = var.cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = "${var.http_directory}/hyperv"
  iso_checksum     = var.iso_checksum
  iso_urls         = var.iso_urls
  memory           = var.memory
  shutdown_command = var.shutdown_command
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = basename(dirname("."))
}