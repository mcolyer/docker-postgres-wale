# Postgres docker container with wale

Based on https://github.com/docker-library/postgres with [WAL-E](https://github.com/wal-e/wal-e) installed.

Environment variables to pass to the container for WAL-E, all of these must be present or WAL-E is not configured.

`AWS_ACCESS_KEY_ID`

`AWS_SECRET_ACCESS_KEY`

`WALE_S3_PREFIX=s3://<bucketname>/<path>`


# AWS S3 security

IAM Policy for backup:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Put*",
                "s3:List*",
                "s3:GetBucketLocation"
            ],
		    "Resource": "arn:aws:s3:::<bucketname>*"
        }
    ]
}
``` 

IAM Policy for restore:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "arn:aws:s3:::<bucketname>*"
        }
    ]
}
```
