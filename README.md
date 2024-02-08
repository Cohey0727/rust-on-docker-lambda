# Rust on Docker Lambda

A repository for running Rust WebAPI on Docker Lambda

## Tech Stack

You need to install the following:

| Name          | Version | Purpose                      |
| ------------- | ------- | ---------------------------- |
| Docker Engine | 25.0.2  | Runtime                      |
| Rust          | 1.75    | Backend language             |
| Direnv        | -       | Environment variable manager |

## Development

### Initialization

```sh
cp .envrc.example .envrc
direnv allow
```

### Running on Host PC

```sh
cargo run
curl -XPOST "http://localhost:8080" -d "{\"firstName\": \"Taro\"}"
```

### Running on Docker Container

```sh
docker compose up -d
curl -XPOST "http://localhost:8081/2015-03-31/functions/function/invocations" -d "{\"firstName\": \"Taro\"}"
```

## Miscellaneous

### Adding crate

You can edit Cargo.toml directly, but you can automatically get the latest version with the following command.

```sh
cargo add crate_name
```

## AWS Login

You need to log in to AWS to pull images from ECR.

```sh
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

Attempting to PULL without logging in will result in an error.

```sh
ERROR: failed to solve: public.ecr.aws/lambda/provided:al2-arm64: unexpected status from HEAD request to <https://public.ecr.aws/v2/lambda/provided/manifests/al2-arm64>: 403 Forbidden
```
