FROM rust:1.43.1

RUN apt-get update -yqq && apt-get install -yqq cmake g++
RUN cargo install diesel_cli --no-default-features --features postgres

COPY ./css ./css
COPY ./javascript ./javascript
COPY ./migrations ./migrations
COPY ./src ./src
COPY ./templates ./templates
COPY ./.env ./.env
COPY ./Cargo.toml ./Cargo.toml
COPY ./diesel.toml ./diesel.toml

WORKDIR .


# add --release later on
RUN cargo build --release

EXPOSE 8000

# "RUST_LOG='info,parser::expression=info,actix_web=info'"

#curl --header "Content-Type: application/json" --request POST --data '{"name":"maxwell","email":"maxwell", "password": "test"}' http://localhost/api/v1/user/create

# add --release later on
CMD ["cargo", "run", "--release"]
