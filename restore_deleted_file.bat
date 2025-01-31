@echo off
rem Set the AWS environment variables
set AWS_ACCESS_KEY_ID=ASIA5FTZDTP2GO4XD5P6
set AWS_SECRET_ACCESS_KEY=fqzAmfqR6qVcPdlHMXkhSU5MnDvnQGuyvF+APSj5
set AWS_SESSION_TOKEN=IQoJb3JpZ2luX2VjEIf//////////wEaCXVzLWVhc3QtMSJGMEQCIEQzA5ZuI8RD3KrYuJsnlbCYfBXsGkwUKSOWlmWkcXNcAiAr7v1tHLPCSHQNR9n8WNvOKBi8WLvS5PbRWHLFz7FsmSroAgiQ//////////8BEAAaDDkwNTQxODM0OTU1NiIMgLeXI4wP+jwN2APfKrwCCYQx9tAXkjJDvUBX4dCH88lceRlep3+iSCPbO4R3AP7IROOEdTIEZHXn4MnDY0HRHNmCx4Nh2LKLlwX2dou73DdrsZdmYi8Jv3E0qvn0oJGHz2n98fvMc+V1npmkpwokesj5xqpWYL3gpmhUj9dthBrxmWUfRuqKhZNREIGiiB82r6q3Fggno8rNFcCzqIlGUbdWkWuNvtDgfVkAVXuYPcxA5YOC2Yf8bGVVB0W5YoeePSO6jiLsUZrCTuv3E/T/yxJS5KSqv1WDTS5MrvVuwMg5GsmVCiSl738LckYxyqfoUl8kucgKE4s7leGmt+gH/ePKM+xWZ6UZyxFPh7w9LG9XiO6O7DBk61ctHg5bTKRELpAky37QvZ8hZffoeUjuE2LSOUx2Egzdq3nqh2CfdW40CxaE6m/nFcskbDCwg+m8BjqeAfl45ueP6zRYeZjbgQvVLf5afKbiJq6aFoyDhbRA8Ep3ID14+Mgp0l4BXzupoe0lM98bp4GwN2iIIENpPhQl+EVuMrgtrLceO1Cbp5PWnEppi0pqGrR9Q6OKfKbLq4PdZASz2SQ/n3t0/5aAc9zXpIiA6CM4qWuQekovu7HfsbPVJdbSERoKg52m/f6tdNEAY49zMgCGO4wDYIlFEUxy
set AWS_DEFAULT_REGION=eu-central-1

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
