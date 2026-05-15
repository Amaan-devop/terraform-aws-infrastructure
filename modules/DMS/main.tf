
resource "aws_dms_replication_instance" "dms_" {
  allocated_storage          = var.storage_size
  apply_immediately          = true
  auto_minor_version_upgrade = true
  multi_az                   = true
  replication_instance_class = var.instance_type
  replication_instance_id    = var.instance_id

  tags = {
    Name = var.instance_id
  }
  replication_subnet_group_id = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

}
