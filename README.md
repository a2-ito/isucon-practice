# isucon-practice

## チューニング項目

### OS
### create sandbox
```
gcloud compute instances create isucon-instance \
  --image-project=ubuntu-os-cloud \
  --image-family=ubuntu-2010 \
  --machine-type=f1-micro \
  --zone=us-west1-a
```

- install tools
  - netdata
  - alp
  - Cloud Profiler
  - Cloud Tracer

```
for num in 1;
do
  scp ./install-tools.sh isucon${num}:~
  ssh isucon${num} "\
    chmod +x ./install-tools.sh
    ./install-tools.sh
  "
done
```

- alp
```
cat access.log | alp ltsv
```

```
sudo sh -c 'echo "* * * * * vagrant /home/vagrant/alp-cron.sh" > /etc/cron.d/alp'
```
### Google Cloud
- サービスアカウントの作成

```
gcloud iam service-accounts list
```

```
gcloud iam service-accounts create sa-for-isucon \
    --description="ISUCON Service Account" \
    --display-name="isucon service account"

gcloud projects add-iam-policy-binding ai-gcp-test-project \
    --member serviceAccount:sa-for-isucon@ai-gcp-test-project.iam.gserviceaccount.com \
    --role roles/cloudprofiler.agent,roles/cloudtrace.agent

gcloud projects add-iam-policy-binding ai-gcp-test-project \
    --member serviceAccount:sa-for-isucon@ai-gcp-test-project.iam.gserviceaccount.com \
    --role roles/cloudtrace.agent

gcloud iam service-accounts keys create \
    ~/key.json \
    --iam-account sa-for-isucon@ai-gcp-test-project.iam.gserviceaccount.com
```

### go

```
export GOOGLE_CLOUD_PROJECT=ai-gcp-test-project
export GOOGLE_APPLICATION_CREDENTIALS=./gcp-sa-key.json
```

- Profiler エージェントのインストール
```
go get -u cloud.google.com/go/profiler
```
```
import (
        "cloud.google.com/go/profiler"
)
```
```
func initProfiler() {
	if err := profiler.Start(profiler.Config{
		Service:        "isucon-20190905",
		ServiceVersion: "1.0.0",
		ProjectID:      os.Getenv("GOOGLE_CLOUD_PROJECT"),
	}); err != nil {
		log.Fatal(err)
	}
}
```
```
initProfiler()
```

### Java
- Profiler エージェントのインストール

```
export GOOGLE_CLOUD_PROJECT=ai-gcp-test-project
export GOOGLE_APPLICATION_CREDENTIALS=./gcp-sa-key.json
```

```
java \
  -agentpath:/opt/cprof/profiler_java_agent.so=-cprof_service=hello-world,-cprof_service_version=1.0.0,-cprof_project_id=${GOOGLE_CLOUD_PROJECT} \
  Main
```

```
java \
  -agentpath:/opt/cprof/profiler_java_agent.so=-cprof_service=java-sprint-boot,-cprof_service_version=1.0.0,-logtostderr,-cprof_project_id=${GOOGLE_CLOUD_PROJECT} \
  -jar isucon4/qualifier/webapp/java-spring-boot/target/java-spring-boot-1.0.0.jar
```

- Tracer エージェントのインストール

```
vi pom.xml
```
```
<dependency>
  <groupId>io.opencensus</groupId>
  <artifactId>opencensus-api</artifactId>
  <version>0.28.3</version>
</dependency>
<dependency>
  <groupId>io.opencensus</groupId>
  <artifactId>opencensus-exporter-trace-stackdriver</artifactId>
  <version>0.28.3</version>
</dependency>
<dependency>
  <groupId>io.opencensus</groupId>
  <artifactId>opencensus-impl</artifactId>
  <version>0.28.3</version>
  <scope>runtime</scope>
</dependency>
<dependency>
   <groupId>joda-time</groupId>
   <artifactId>joda-time</artifactId>
   <version>2.10.8</version>
</dependency>
```





- DB接続先変更

```
vi java/src/main/resources/application.yml
```

## python
- Profiler エージェントのインストール
```
export GOOGLE_CLOUD_PROJECT=ai-gcp-test-project
export GOOGLE_APPLICATION_CREDENTIALS=./gcp-sa-key.json
```
```
pip3 install google-cloud-profiler
```
```
import googlecloudprofiler
```
```
def init_profiler():
    try:
        googlecloudprofiler.start(
            service='isucon-python',
            service_version='1.0.0',
            verbose=3,
        )
    except (ValueError, NotImplementedError) as exc:
        print(exc)  # Handle errors herea
```

### Apache
- ログ出力を alp 対応形式にする

```
LogFormat "time:%t\tforwardedfor:%{X-Forwarded-For}i\thost:%h\treq:%r\tstatus:%>s\tmethod:%m\turi:%U%q\tsize:%B\treferer:%{Referer}i\tua:%{User-Agent}i\treqtime_microsec:%D\tapptime:%D\tcache:%{X-Cache}o\truntime:%{X-Runtime}o\tvhost:%{Host}i" combined
```

- キャッシュ

### MySQL
- スロークエリ設定
- メモリチューニング
- 実行計画を確認する
- メモリに載せる

### Aapplication
- sql をマージする
- インデックス追加
- マスタをメモリに持たせる

## Docker

```
docker 
```

## Aapache

## nginx
-静的コンテンツキャッシュ
```
expires 1d;
```

## Update log format for alp

```
	log_format ltsv "time:$time_local"
		"\thost:$remote_addr"
		"\tforwardedfor:$http_x_forwarded_for"
		"\treq:$request"
		"\tstatus:$status"
		"\tmethod:$request_method"
		"\turi:$request_uri"
		"\tsize:$body_bytes_sent"
		"\treferer:$http_referer"
		"\tua:$http_user_agent"
		"\treqtime:$request_time"
		"\tcache:$upstream_http_x_cache"
		"\truntime:$upstream_http_x_runtime"
		"\tapptime:$upstream_response_time"
		"\tvhost:$host";
	access_log /var/log/nginx/access.log ltsv;
```

## MySQL

### 情報取得
#### 現在の接続数
```
show global status like 'Threads_connected';
```
#### 最大接続数
```
show global variables like 'max_connections';
```
#### タイムアウト設定値確認
```
show global variables like 'wait_timeout%';
```

### Enable slow queries log
```
vi my.cnf
```

```
slow_query_log		= 1
slow_query_log_file	= /var/log/mysql/mysql-slow.log
long_query_time = 0
```

## ログメンテ


