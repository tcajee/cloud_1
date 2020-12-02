# // Create Load Balancer Service
# resource "kubernetes_service" "load_balancer" {
#   metadata {
#     name = "load-balancer"
#     labels = {
#       env = "Production"
#     }
#   }

#   spec {
#     type = "LoadBalancer"
#     selector = {
#       pod = kubernetes_deployment.wp_dep.spec.0.selector.0.match_labels.pod
#     }

#     port {
#       name = "lb-port"
#       port = 80
#     }
#   }

#   depends_on = [
#     kubernetes_deployment.wp_dep,
#   ]
# }