output "wp_service_url" {
  value = kubernetes_service.load_balancer.load_balancer_ingress.0.ip

  depends_on = [
    kubernetes_service.load_balancer
  ]
}

output "db_host" {
  value = google_sql_database_instance.mysql.ip_address.0.ip_address

  depends_on = [
    google_sql_database_instance.mysql
  ]
}

output "database_name" {
  value = var.database

  depends_on = [
    google_sql_database_instance.mysql
  ]
}

output "db_user_name" {
  value = var.db_user

  depends_on = [
    google_sql_database_instance.mysql
  ]
}

output "db_user_passwd" {
  value = var.db_user_pass

  depends_on = [
    google_sql_database_instance.mysql
  ]
}
