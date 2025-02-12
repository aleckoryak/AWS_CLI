iam_task3_AWS_KMS_Customer_Managed_Key

cmtr-2fa561ce



kms key
arn:aws:kms:eu-central-1:905418349556:key/edc6d8df-9b65-43ac-8813-3fa592d96c37

IAM
role arn:aws:iam::905418349556:role/cmtr-2fa561ce-iam-sewk-iam_role

create iam_task3_AllowAccessToKMSKeyPolicy.json

aws iam put-role-policy --role-name cmtr-2fa561ce-iam-sewk-iam_role --policy-name AllowAccessToKMSKey --policy-document file://./iam_task3_AllowAccessToKMSKeyPolicy.json

aws iam list-role-policies --role-name cmtr-2fa561ce-iam-sewk-iam_role


S3
arn:aws:s3:::cmtr-2fa561ce-iam-sewk-bucket-9604494-1
arn:aws:s3:::cmtr-2fa561ce-iam-sewk-bucket-9604494-2


s3 Server-Side Encryption 

 create iam_task3_S3_encryption-config.json
 
 aws s3api put-bucket-encryption --bucket cmtr-2fa561ce-iam-sewk-bucket-9604494-2 --server-side-encryption-configuration file://./iam_task3_S3_encryption-config.json
 
 aws s3api get-bucket-encryption --bucket cmtr-2fa561ce-iam-sewk-bucket-9604494-2
 
 
 copy file 
 aws s3 cp s3://cmtr-2fa561ce-iam-sewk-bucket-9604494-1/confidential_credentials.csv s3://cmtr-2fa561ce-iam-sewk-bucket-9604494-2/confidential_credentials.csv
 OR 
 aws s3 cp s3://cmtr-2fa561ce-iam-sewk-bucket-9604494-1/confidential_credentials.csv s3://cmtr-2fa561ce-iam-sewk-bucket-9604494-2/confidential_credentials.csv --sse aws:kms --sse-kms-key-id arn:aws:kms:eu-central-1:905418349556:key/edc6d8df-9b65-43ac-8813-3fa592d96c37
 
 aws s3 ls s3://cmtr-2fa561ce-iam-sewk-bucket-9604494-2/confidential_credentials.csv