resource "aws_iam_role" "ec2-access-s3-role" {
  name               = "ec2-access-s3-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "s3-mybucket-role" {
  name = "s3-mybucket-role"
  role = aws_iam_role.ec2-access-s3-role.name
}


resource "aws_iam_role_policy" "ec2-access-s3-policy" {
  name = "ec2-access-s3-policy"
  role = aws_iam_role.ec2-access-s3-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::mybucket-c29df123",
              "arn:aws:s3:::mybucket-c29df123/*"
            ]
        }
    ]
}
EOF

}



