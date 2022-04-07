(Note that if you don't want to have a public web page and just want to use it to "git push to the bucket" you don't have to neither make your repo public nor add the AllUsers user.)

1. make a public static website bucket as explained in relevant [YC docs](https://cloud.yandex.com/en/docs/storage/operations/hosting/setup)
2. create a Service Account without any permissions and generate its Static Key credentials
3. add it in the bucket's ACL as "READ and WRITE"
4. make a Github repo and a directory in it with the same name as your bucket (designed to be able to update multiple buckets from a single repo)
5. in the repo Settings -> Security -> Secrets add the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars equal to values in the Static Key you've generated in the step 2
6. add a Workflow to your repo like this: https://github.com/Nakilon/www-nakilon-pro/blob/master/.github/workflows/sync.yaml

---

**Warning:** files that are missing from the repo will be deleted from the bucket. They'll still remain in the git history so it's dangerous only when you use this thing the first time.

---

**Development notes:**

```bash
mkdir mybucket
echo hello > mybucket/world
docker build --progress plain -t temp . < Dockerfile
AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... docker run --rm -ti -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -v $(pwd):/repo:ro -w /repo temp
```
