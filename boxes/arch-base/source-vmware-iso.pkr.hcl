source "vmware-iso" "default" {
  cdrom_adapter_type = "ide"
  disk_adapter_type  = "scsi"
  disk_type_id       = 0
  guest_os_type      = "otherGuest64"
  network            = "vmnet8"
  output_directory   = "output-vmware"
  vmx_data = {
    firmware = "efi"
  }

  communicator     = var.communicator
  cpus             = var.cpus
  cores            = var.cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = "${var.http_directory}/vmware"
  iso_checksum     = var.iso_checksum
  iso_urls         = var.iso_urls
  memory           = var.memory
  shutdown_command = var.shutdown_command
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = basename(dirname("."))
}