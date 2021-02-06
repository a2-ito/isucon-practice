# isucon-practice

## チューニング項目

### OS
- install tools
  - netdata
  - alp
  - Cloud Profiler
  - Cloud Tracer

- alp
```
cat access.log | alp ltsv
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
    --role roles/cloudprofiler.agent

gcloud iam service-accounts keys create \
    ~/key.json \
    --iam-account sa-for-isucon@ai-gcp-test-project.iam.gserviceaccount.com
```

### Java
- Profiler エージェントのインストール
- Tracer エージェントのインストール

### Apache
- ログ出力を alp 対応形式にする

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
## Update log format for alp
```
LogFormat "time:%t\tforwardedfor:%{X-Forwarded-For}i\thost:%h\treq:%r\tstatus:%>s\tmethod:%m\turi:%U%q\tsize:%B\treferer:%{Referer}i\tua:%{User-Agent}i\treqtime_microsec:%D\tapptime:%D\tcache:%{X-Cache}o\truntime:%{X-Runtime}o\tvhost:%{Host}i" ltsv
```

## nginx

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
slow_query_log		= 1
slow_query_log_file	= /var/log/mysql/mysql-slow.log
long_query_time = 0
```

## ログメンテ


