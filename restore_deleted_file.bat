@echo off
rem Set the AWS environment variables
set AWS_ACCESS_KEY_ID=
set AWS_SECRET_ACCESS_KEY=
set AWS_SESSION_TOKEN=set AWS_DEFAULT_REGION=eu-central-1

rem Perform AWS CLI commands using PowerShell
rem pull all buckets
powershell -Command "aws s3 ls"
rem select bucket by prefix name
powershell -Command "aws s3api list-buckets --query 'Buckets[].Name' | Select-String 'PREFIX'"
rem pull objects from identified bucket
powershell -Command "aws s3api list-object-versions --bucket "BUCKET"
rem restore object by name and version
powershell -Command "aws s3api delete-object --bucket BUCKET --key OBJECT_KEY --version-id VERSION"
rem check current state of object
powershell -Command "aws s3api list-object-versions --bucket BUCKET --prefix OBJECT_KEY"

endlocal
