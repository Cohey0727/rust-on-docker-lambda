# Rust on Docker Lambda

RustのWebAPIをDocker Lambdaで動かすためのリポジトリ

## 技術スタック

以下をインストールする必要があります。

| Name          | Version | Purpose                      |
| ------------- | ------- | ---------------------------- |
| Docker Engine | 25.0.2  | Runtime                      |
| Rust          | 1.75    | backend language             |

## 開発

### ホストPCで実行

```sh
cargo run
```

### Dockerで起動

```sh
docker compose up -d
curl -XPOST "http://localhost:8081/2015-03-31/functions/function/invocations" -d "{\"firstName\": \"Taro\"}"
```

## その他

### adding crate

Cargo.tomlを直接編集してもいいですが、以下のコマンドで自動的に最新バージョンを取得できます。

```sh
cargo add crate_name
```

## AWS Login

ECRからイメージをプルするために、AWSにログインする必要があります。

```sh
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

ログインせずにPULLしようとするとエラーになります。

```sh
ERROR: failed to solve: public.ecr.aws/lambda/provided:al2-arm64: unexpected status from HEAD request to https://public.ecr.aws/v2/lambda/provided/manifests/al2-arm64: 403 Forbidden
```
