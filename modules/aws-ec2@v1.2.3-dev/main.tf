data "aws_ami" "this" {
    most_recent = true
    owners      = ["amazon", "099720109477"]  # amazon, canonical

    filter {
        name   = "name"
        values = ["*${var.ec2_image_name}*"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
}

## This section can be activated to generate ssh keys and right the private key to a local file for the user
## Helpful for users who don't know how to genereate ssh keys on their own
/*
resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.generated_key.private_key_pem
  filename          = "private_key.pem"
  file_permission   = "0600"
}
*/
resource "aws_key_pair" "aws_key" {
  key_name   = "${var.name_prefix}-aws_key"
  #public_key = tls_private_key.generated_key.public_key_openssh
  public_key = var.admin_user_pub_key
  tags       = var.tags
}

resource "aws_eip" "lb" {
  instance = aws_instance.compute_instance.id
  vpc      = true
  tags     = var.tags
}


resource "aws_iam_instance_profile" "data_bucket_profile" {
  name = "${var.name_prefix}-main-profile"
  role = var.iam_role_name
  tags = var.tags
}

resource "aws_instance" "compute_instance" {
  ami           = data.aws_ami.this.id
  instance_type = var.ec2_instance_size

  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnet_ids[0]

  key_name             = aws_key_pair.aws_key.key_name
  iam_instance_profile = aws_iam_instance_profile.data_bucket_profile.id

  user_data = var.install_script
  tags     = var.tags
}
