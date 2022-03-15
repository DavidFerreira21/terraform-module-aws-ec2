module "ec2-front-end" {
  source                 = "../modules/ec2"
  name                   = ["Portal-front-01", "Portal-front-02"]
  instance_count         = 2
  instance_type          = ["c5a.2xlarge", "c5a.xlarge"]
  ami                    = ["ami-04505e74c0741db8d"]
  key_name               = "portal-correio-com-br"
  subnet_ids             = [module.vpc_prod.private_subnets_ids["private-a"], module.vpc_prod.private_subnets_ids["private-b"]]
  vpc_security_group_ids = [module.sg_front-end.sg_id]
  ebs_optimized          = false
  monitoring             = true
  root_block_device = [
    {
      delete_on_termination = "true"
      volume_size           = "30"
    }
  ]
  ebs_block_device = [
    {
      device_name           = "/dev/sdb"
      delete_on_termination = "true"
      volume_size           = "20"
      volume_type           = "standard"
    }
  ]
  tags = {
    Enviroment = "prd"
  }
}