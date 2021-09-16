## https://support.lacework.com/hc/en-us/articles/360008318373-Add-the-Name-field-to-the-Machine-Properties-Table
resource "aws_iam_role" "lw_role" {
  name = "lw-role-${random_id.random.hex}"
  path = "/"
  tags = merge(
    local.common_tags,
    {
      "Name" = "lw-role-${random_id.random.hex}"
    },
  )

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

resource "aws_iam_role_policy" "lw_policy" {
  name = "lw-policy-${random_id.random.hex}"
  role = aws_iam_role.lw_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeTags",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "lw_instance_profile" {
  name = "lw-instance-profile-${random_id.random.hex}"
  role = aws_iam_role.lw_role.name
}