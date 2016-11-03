module "stack" {
  source      = "github.com/rnrbarbosa/stack"
  environment = "prod"
  key_name    = "rnrbarbosa"
  name        = "my-demo"
}


module "nginx" {
  # this sources from the "stack//service" module
  source          = "github.com/rnrbarbosa/stack//service"
  name            = "my-demo"
  image           = "nginx"
  port            = 80
  environment     = "${module.stack.environment}"
  cluster         = "${module.stack.cluster}"
  iam_role        = "${module.stack.iam_role}"
  security_groups = "${module.stack.internal_elb}"
  subnet_ids      = "${module.stack.internal_subnets}"
  log_bucket      = "${module.stack.log_bucket_id}"
  zone_id         = "${module.stack.zone_id}"
  dns_name       = "lb"
}
