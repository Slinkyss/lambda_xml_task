resource "aws_iam_role_policy" "lambda_policy1" {
  name = "lambda_policy1"
  role = "${aws_iam_role.lambda_role2.id}"

  
  policy = "${file("iamrole/lambda-policy.json")}"
  
}

resource "aws_iam_role" "lambda_role2" {
  name = "lambda_role1"

  assume_role_policy =  "${file("iamrole/lambda-assume-policy.json")}"
   
  
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}



resource "aws_iam_role_policy" "vpc_exec_role" {
  name = "vpc_exec_role"
  role = aws_iam_role.iam_for_lambda.id
  policy =  "${file("iamrole/vpc_exec_role.json")}"
   
}

resource "aws_iam_role_policy" "s3_lambda_policy" {
  name = "s3_lambda_policy"
  role = aws_iam_role.iam_for_lambda.id
  policy = "${file("iamrole/s3_lambda_policy.json")}"
}
