cmtr-2fa561ce_Assume_Role

$Env:AWS_ACCESS_KEY_ID={ACCESS_KEY_ID}
$Env:AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}
$Env:AWS_SESSION_TOKEN={AWS_SESSION_TOKEN}
$env:AWS_DEFAULT_REGION = "eu-central-1"

cmtr-2fa561ce

aws iam get-role --role-name cmtr-2fa561ce-iam-ar-iam_role-readonly
arn:aws:iam::905418349556:role/cmtr-2fa561ce-iam-ar-iam_role-readonly


aws iam get-role --role-name cmtr-2fa561ce-iam-ar-iam_role-assume



aws iam put-role-policy --role-name cmtr-2fa561ce-iam-ar-iam_role-assume --policy-name assume_role_permissions --policy-document file://./cmtr-2fa561ce_assume_role_trust_policy.json

aws iam attach-role-policy --role-name cmtr-2fa561ce-iam-ar-iam_role-readonly --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

aws iam update-assume-role-policy --role-name cmtr-2fa561ce-iam-ar-iam_role-readonly --policy-document file://./cmtr-2fa561ce_readonly_role_trust_policy.json


