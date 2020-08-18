resource "aws_instance" "amazonLinux" {
                                       ami           = "ami-0fc61db8544a617ed"
                                       instance_type = "t2.micro"

                                       # the VPC subnet
                                       subnet_id = aws_subnet.MySubnet-public.id

                                       # the security group
                                       vpc_security_group_ids = [aws_security_group.MySecurityGroup.id]

                                       # the public SSH key
                                       key_name = "aws"
  
                                       # the role 
                                       iam_instance_profile= "${aws_iam_instance_profile.s3-mybucket-role.name}"
  
                                       tags= { Name= "amazonLinux"}
                                      }

  #user_data
  user_data= <<-EOF
#!/bin/bash
# Install Apache Web Server and PHP
sudo su
yum install -y httpd mysql
amazon-linux-extras install -y php7.2
# Download Lab files from S3 bucket
aws s3 cp s3://mybucket-c29df123/inventory-app.zip .
unzip inventory-app.zip -d /var/www/html/
 # Download and install the AWS SDK for PHP From S3 bucket
aws s3 cp s3://mybucket-c29df123/aws.zip .
unzip aws -d /var/www/html
# Turn on web server
chkconfig httpd on
service httpd start
EOF


}
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.amazonLinux.id
}







