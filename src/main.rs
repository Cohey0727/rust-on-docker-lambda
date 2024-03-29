use lambda_runtime::{service_fn, Error, LambdaEvent};
use serde_json::{json, Value};

async fn handler(event: LambdaEvent<Value>) -> Result<Value, Error> {
    println!("Received event: {:?}", event);
    let payload = event.payload;
    let first_name = payload["firstName"].as_str().unwrap_or("world");
    Ok(json!({ "message": format!("Hello, {first_name}!") }))
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    println!("Starting lambda");
    lambda_runtime::run(service_fn(handler)).await
}
