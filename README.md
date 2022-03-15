
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |
# Examples

``` hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | ID of AMI to use for the instance | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `list(string)` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | If true, the EC2 instance will have associated public IP address | `bool` | `null` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `false` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch | `number` | `1` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name to use for the instance | `string` | `""` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | A list of names to associate with | `list(string)` | `null` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Customize network interfaces to be attached at instance boot time | `list(map(string))` | `[]` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| <a name="input_private_ips"></a> [private\_ips](#input\_private\_ips) | A list of private IP address to associate with the instance in a VPC. Should match the number of instances. | `list(string)` | `[]` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `list(map(string))` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC Subnet IDs to launch in | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of security group IDs to associate with | `list(string)` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | List of ARNs of instances |
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | List of availability zones of instances |
| <a name="output_id"></a> [id](#output\_id) | List of IDs of instances |
| <a name="output_instance_state"></a> [instance\_state](#output\_instance\_state) | List of instance states of instances |
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | List of key names of instances |
| <a name="output_primary_network_interface_id"></a> [primary\_network\_interface\_id](#output\_primary\_network\_interface\_id) | List of IDs of the primary network interface of instances |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | List of private IP addresses assigned to the instances |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | List of public IP addresses assigned to the instances, if applicable |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | List of IDs of VPC subnets of instances |
## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

