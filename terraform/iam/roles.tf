###################################################
# Assume Role Policy Document
###################################################

data "aws_iam_policy_document" "dev_assume_role" {

  statement {

    effect = "Allow"

    actions = [

      "sts:AssumeRole"

    ]

    principals {

      type = "Service"

      identifiers = [

        "ec2.amazonaws.com"

      ]

    }

  }

}

###################################################
# IAM Role
###################################################

resource "aws_iam_role" "dev" {

  name = "${local.prefix}-dev-role"

  assume_role_policy = data.aws_iam_policy_document.dev_assume_role.json

}


###################################################
# Attach S3 Policy to Puter Role
###################################################

resource "aws_iam_role_policy_attachment" "dev_s3" {

  role = aws_iam_role.dev.name

  policy_arn = aws_iam_policy.s3.arn

}