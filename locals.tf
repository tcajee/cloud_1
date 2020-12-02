 locals {

   subnets = {
     main = {
       public = {
         name = "wp"
         cidr = "10.2.0.0/16"
       }
     }
   }
 
   # example common tags which should be applied to all resources for cost tracking ect.
   common_tags = {
     project_name = var.project_name
     cost_centre  = "cld1cc"
   }
  }
}
