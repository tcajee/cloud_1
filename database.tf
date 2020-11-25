// Configure SQL Database instance
resource "google_sql_database_instance" "mysql" {
  name             = "MySQL"
  database_version = "MYSQL_5_6"
  region           = var.region2
  root_password    = var.root_pass

  settings {
    tier = "db-f1-micro" // <-------------------------------------- Check this

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "sqlnet" // <-------------------------------------- Check this
        value = "0.0.0.0/0" // <-------------------------------------- Check this

      }
    }
  }

  depends_on = [
    google_compute_subnetwork.db_subnet
  ]
}

// Create SQL Database
resource "google_sql_database" "mysql_db" {
  name     = var.database
  instance = google_sql_database_instance.mysql.name

  depends_on = [
    google_sql_database_instance.mysql
  ]
}

// Create SQL Database User
resource "google_sql_user" "mysql_user" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql.name
  password = var.db_user_pass

  depends_on = [
    google_sql_database_instance.mysql
  ]
}
