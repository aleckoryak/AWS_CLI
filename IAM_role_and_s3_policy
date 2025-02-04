powershell
$Env:AWS_ACCESS_KEY_ID={ACCESS_KEY_ID}
$Env:AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}
$Env:AWS_SESSION_TOKEN={AWS_SESSION_TOKEN}
$env:AWS_DEFAULT_REGION = "eu-central-1"

 aws iam list-roles --query "Roles[?starts_with(RoleName, 'cmtr-2fa561ce')].RoleName"
 aws iam get-role --role-name cmtr-2fa561ce-iam-peld-iam_role
 aws iam attach-role-policy --role-name cmtr-2fa561ce-iam-peld-iam_role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
 
 
 aws s3api list-buckets --query "Buckets[].Name"  | Select-String "cmtr-2fa561ce"
 
 aws s3api get-bucket-policy --bucket cmtr-2fa561ce-iam-peld-bucket-5480082 --output json > existing-policy.json
 
 
 update the existing-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Deny",
      "Principal": {
        "AWS": "arn:aws:iam::905418349556:role/cmtr-2fa561ce-iam-peld-iam_role"
      },
      "Action": "s3:DeleteObject",
      "Resource": "arn:aws:s3:::cmtr-2fa561ce-iam-peld-bucket-5480082/*"
    }
  ]
}



aws s3api put-bucket-policy --bucket cmtr-2fa561ce-iam-peld-bucket-5480082 --policy file://C:/{path}/existing-policy.json
