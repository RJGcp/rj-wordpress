resource "google_sql_database_instance" "wordpress_db" {
  name             = "wordpress-db"
  region           = var.region
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-n1-standard-1"

    ip_configuration {
      authorized_networks {
        value = google_compute_instance.wordpress.network_interface.0.access_config.0.nat_ip
      }
    }
  }
}

resource "google_sql_database" "wordpress" {
  name       = "wordpress"
  instance   = google_sql_database_instance.wordpress_db.name
}

resource "google_sql_user" "wordpress_user" {
  name     = "wordpress_user"
  instance = google_sql_database_instance.wordpress_db.name
  password = var.db_password
}