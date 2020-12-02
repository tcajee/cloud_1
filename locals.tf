 locals {

  subnets = {
    main = {
      public = {
        name = "wp"
        cidr = "10.2.0.0/16"
      }
    }
  }

}
