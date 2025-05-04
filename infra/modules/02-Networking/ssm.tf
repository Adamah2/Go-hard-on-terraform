resource "aws_ssm_parameter" "vpc_id" {
  name  = local.ssm_vpc_param_name
  type  = "String"
  value = aws_vpc.main.id
}

resource "aws_ssm_parameter" "subnet_ids" {
  name  = local.ssm_subnets_name
  type  = "StringList"
  value = join(",", aws_subnet.public_subnets[*].id)
}
