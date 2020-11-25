// Create SQL Database
resource "google_sql_database" "mysql_db" {
  name     = var.db_name
  instance = google_sql_database_instance.mysql_instance.name

  depends_on = [
    google_sql_database_instance.mysql_instance
  ]
}

// Create SQL Database User
resource "google_sql_user" "mysql_user" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql_instance.name
  password = var.db_user_pass

  depends_on = [
    google_sql_database_instance.mysql_instance
  ]
}

// Configure SQL Database instance
resource "google_sql_database_instance" "mysql_instance" {
  name             = "mysql-instance"
  database_version = "MYSQL_5_6"
  region           = var.region2
  root_password    = var.db_root_pass

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "sqlnet"
        value = local.subnets.main.database.cidr

      }
    }
  }

  depends_on = [
    google_compute_subnetwork.db_subnet
  ]
}