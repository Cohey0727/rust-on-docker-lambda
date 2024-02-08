# Build stage
FROM rust:1.75.0 AS builder
WORKDIR /opt/app
# Copying dependencies first to leverage Docker cache and speed up the build
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# Installing the toolchain for cross-compilation
RUN rustup update && \
    rustup target add aarch64-unknown-linux-gnu
# Build
RUN cargo build --release --target aarch64-unknown-linux-gnu

# Execution stage
FROM public.ecr.aws/lambda/provided:al2023
# Copying the built executable to be used as the Lambda runtime executable
COPY --from=builder /opt/app/target/aarch64-unknown-linux-gnu/release/command_ai ${LAMBDA_RUNTIME_DIR}/bootstrap
# Specifying the handler function (not actually used in custom runtime, but kept for information)
CMD ["app.handler"]
