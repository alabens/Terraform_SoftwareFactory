# Internet VPC
resource "aws_vpc" "MyVpc" {
                                cidr_block           = "10.0.0.0/16"
                                instance_tenancy     = "default"
                                enable_dns_support   = "true"
                                enable_dns_hostnames = "true"
                                enable_classiclink   = "false"
                                tags = { Name = "MyVpc"}
                           }

# Subnets
resource "aws_subnet" "MySubnet-public" {
                                          vpc_id                  = aws_vpc.MyVpc.id
                                          cidr_block              = "10.0.1.0/24"
                                          map_public_ip_on_launch = "true"
                                          availability_zone       = "us-east-2a"
                                          tags = {Name = "MySubnet-public"}
                                        }

# Internet GW
resource "aws_internet_gateway" "MyGateway" {
                                              vpc_id = aws_vpc.MyVpc.id
                                              tags = { Name = "MyGateway" }
                                            }



# route tables
resource "aws_route_table" "MyRouteTable-public" {
                                                   vpc_id = aws_vpc.MyVpc.id
                                                   route {
                                                          cidr_block = "0.0.0.0/0"
                                                          gateway_id = aws_internet_gateway.MyGateway.id
                                                         }
                                                   tags = { Name = "MyRouteTable"}
}

# route associations public
resource "aws_route_table_association" "MyRouteAssociate" {
                                                            subnet_id      = aws_subnet.MySubnet-public.id
                                                            route_table_id = aws_route_table.MyRouteTable-public.id
                                                         }


