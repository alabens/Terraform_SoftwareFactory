resource "aws_s3_bucket" "mybucket-c29df123" {
  bucket = "mybucket-c29df123"
  acl    = "private"
  force_destroy  = "true"

  #provisioner "local-exec" {
     #command = "aws s3 cp ./files/aws.zip s3://mybucket-c29df123"
     #command = "aws s3 cp inventory-app.zip aws_s3_bucket.mybucket-c29df123.id"
  #}

  tags = {
    Name = "MyBucket"
  }
}

resource "aws_s3_bucket_object" "file1" {
  bucket = "mybucket-c29df123"
  key    = "inventory-app.zip"
  source = "./files/inventory-app.zip"
  #etag = "${filemd5("inventory-app.zip")}"


}


resource "aws_s3_bucket_object" "file2" {
  bucket = "mybucket-c29df123"
  key    = "aws.zip"
  source = "./files/aws.zip"
  #etag = "${filemd5("aws.zip")}"

}


