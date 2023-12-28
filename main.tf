resource "google_compute_instance" "wordpress" {
  name         = "wordpress-instance"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "family/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2 php libapache2-mod-php php-mysql
    wget https://wordpress.org/latest.tar.gz
    tar xvf latest.tar.gz
    sudo cp -R wordpress/* /var/www/html/
    sudo chown -R www-data:www-data /var/www/html/
    sudo systemctl restart apache2
  EOT
}