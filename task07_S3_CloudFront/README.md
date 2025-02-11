task07 Securing access to S3 content by using a CloudFront origin access identity

## Description
Note: Keep in mind that CloudFront can take a long time to create and deploy, potentially 15 minutes or more.

The goal of this task is to host a static website using Amazon S3, distribute content through a worldwide network of data centers called edge locations using CloudFront, and restrict access to the S3 bucket using Origin Access Identity (OAI) by setting proper configurations and permissions.

Region-specific resources are created in the eu-central-1} region.

## Task Resources
In this task, you will work with the following resources:
+ prefix: cmtr-2fa561ce
+ s3: cmtr-2fa561ce-cloudfront-sswo-bucket-2397860
+ cloudFront: cmtr-2fa561ce-cloudfront-sswo-distribution |domain name: d34gae9ahga7kf.cloudfront.net | ID E3CH22V46DXYIS

+ S3 bucket ${bucket_name}: This bucket contains two files, index.html and error.html, and static website hosting has already been configured for you.
+ CloudFront distribution ${cloudfront_distribution}: This distribution is configured to deliver the content of the ${bucket_name} bucket.
+OAI ${cloudfront_oai}: You will configure the CloudFront distribution to use this Origin Access Identity.

## Objectives
In four moves, you must restrict direct access to the S3 bucket using CloudFront OAI.

1. Add an OAI to the ${cloudfront_distribution} distribution.
2. Edit the CloudFront error page to return a custom error response to the viewer. Set the HTTP error code to 403, the response page to error.html, and the response code to 404.
3. Configure the bucket to restrict public access.
4. Grant the OAI permission to read files in the ${bucket_name} S3 bucket.
One move is to create, update, or delete an AWS resource. Some verification steps may pass without any action being applied, but to complete the task you must ensure that all the steps are passed.

## Additional Resources
+ [get-distribution-config](https://docs.aws.amazon.com/cli/latest/reference/cloudfront/get-distribution-config.html)
+ [update-distribution](https://docs.aws.amazon.com/cli/latest/reference/cloudfront/update-distribution.html)
+ [put-bucket-policy](https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-policy.html)


## Task Verification
To ensure everything is set up correctly, check that:

Viewers cannot use AWS S3 URLs to access your files outside of CloudFront. The website endpoint of the S3 bucket should return AccessDenied when accessed using a browser.
CloudFront OAI can access files in the bucket on behalf of viewers who are requesting them through CloudFront. The CloudFront domain should open index.html. To check the error response, try accessing a non-existent page, e.g., https://${random_id}.cloudfront.net/database.html. It should return error.html.


---

# Steps

```powershell
$Env:AWS_ACCESS_KEY_ID=AWS_ACCESS_KEY_ID
$Env:AWS_SECRET_ACCESS_KEY=AWS_SECRET_ACCESS_KEY
$Env:AWS_SESSION_TOKEN=AWS_SESSION_TOKEN
$env:AWS_DEFAULT_REGION = "eu-central-1"
```

## S3[distribution-config.json](distribution-config.json)

1. create S3
```powershell
aws s3api create-bucket --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860 --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1

Location": "http://cmtr-2fa561ce-cloudfront-sswo-bucket-2397860-temp.s3.amazonaws.com/

aws s3api get-bucket-location --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860

aws s3 ls s3://cmtr-2fa561ce-cloudfront-sswo-bucket-2397860/
[distribution-config.json](distribution-config.json)
aws s3 cp index.html s3://cmtr-2fa561ce-cloudfront-sswo-bucket-2397860/index.html
[distribution-config.json](distribution-config.json)
aws s3 cp index.html s3://cmtr-2fa561ce-cloudfront-sswo-bucket-2397860/index.html

aws s3 website s3://cmtr-2fa561ce-cloudfront-sswo-bucket-2397860/ --index-document index.html --error-document error.html
```

2. Restrict Public Access to S3 Bucket
```powershell
aws s3api put-public-access-block --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860 --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
or to disable all
aws s3api put-public-access-block --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860 --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

aws s3api get-public-access-block --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860
```

3. Create Cloud Front 
```powershell
aws cloudfront get-distribution-config --id E3CH22V46DXYIS --output json > distribution-config.json[modification2-distribution-config.json](modification2-distribution-config.json)

aws cloudfront create-distribution --distribution-config file://./distribution-config.json 
```

4. Add an OAI to the CloudFront Distribution
+ For the Origin access, select Legacy access identities.
+ In the Origin Access Identity dropdown, select the cmtr-2fa561ce-cloudfront-sswo-oai OAI.

update distribution-config.json set the following
```powershell
aws cloudfront list-cloud-front-origin-access-identities
```

```json
            "S3OriginConfig": {
                "OriginAccessIdentity": "origin-access-identity/cloudfront/E1UPC3Z3VS1WCY"
            }
```
```powershell
aws cloudfront update-distribution --id E3CH22V46DXYIS --distribution-config file://./modified-distribution-config.json --if-match E3IRKF9YMEUL90 
```

+ For the Bucket policy, select Yes, update the bucket policy.
```powershell
aws s3api put-bucket-policy --bucket cmtr-2fa561ce-cloudfront-sswo-bucket-2397860 --policy file://./new-bucket-policy.json 
```
5. Configure CloudFront Error Page

+ modification to modified-distribution-config.json
```json
"CustomErrorResponses": {
    "Quantity": 1,
    "Items": [
        {
            "ErrorCode": 403,
            "ResponsePagePath": "/error.html",
            "ResponseCode": "404",
            "ErrorCachingMinTTL": 300
        }
    ]
}
```

```powershell
aws cloudfront update-distribution --id E3CH22V46DXYIS --distribution-config file://./modification2-distribution-config.json --if-match EJGJSTRIIC4JW 
```