After pushing to the master branch of the repository that uses this Github Action contents of its directories will be syncronized with corresponding Object Storage (such as Yandex Object Storage or Google Cloud Storage) buckets.

---

For example I am now updating my home page using it. If you want to do the same see the following steps. (Note that if you don't want to have a public web page and just want to use it to "git push to the bucket" you don't have to neither make your repo public nor add the AllUsers user.)

**Yandex**:

1. make a public static website bucket as explained in relevant [YC docs](https://cloud.yandex.com/en/docs/storage/operations/hosting/setup)
2. create a Service Account without any permissions and generate its Static Key credentials
3. add it in the bucket's ACL as "READ and WRITE"
4. make a Github repo and a directory in it with the same name as your bucket (designed to be able to update multiple buckets from a single repo)
5. in the repo Settings -> Security -> Secrets add the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars equal to values in the Static Key you've generated in the step 2
6. add a Workflow to your repo like this: https://github.com/Nakilon/www-nakilon-pro/blob/master/.github/workflows/sync.yaml

**Google** (not included yet, use the legacy [Git-to-GCS Github Action](https://github.com/Nakilon/git-to-gcs) instead):

---

**Warning:** files that are missing from the repo will be deleted from the bucket. They'll still remain in the git history so it's dangerous only when you use this thing the first time.

---

**Development notes:**

hot testing Yandex:
```bash
cd Yandex
mkdir mybucket
echo hello > mybucket/world
docker build --progress plain -t temp . < Dockerfile
AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... docker run --rm -ti -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -v $(pwd):/repo:ro -w /repo temp
```
