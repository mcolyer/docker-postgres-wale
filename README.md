# Postgres 9.4 Docker container with WAL-E

Based on https://github.com/docker-library/postgres with [WAL-E](https://github.com/wal-e/wal-e) installed.

## Cron Configuration

Since cron doesn't run inside containers you'll need to run the
following commands on a recurring basis:

```shell
# Suggested cron definition: 0 3 * * *
docker run <container> -u postgres /usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e backup-push /var/lib/postgresql/data
# Suggested cron definition: 0 4 * * *
docker run <container> -u postgres /usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e delete --confirm retain 7
```

## AWS Configuration

Environment variables to pass to the container for WAL-E, all of these must be present or WAL-E is not configured.

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `ARCHIVE_S3_PREFIX=s3://<bucketname>/<path>`
* `RESTORE_S3_PREFIX=s3://<bucketname>/<path>` - optional, if present
  the latest backup is used to initialize the database.


## AWS S3 security

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
