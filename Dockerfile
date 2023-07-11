FROM rust AS build

RUN rustup target add wasm32-unknown-unknown
RUN cargo install wasm-bindgen-cli
WORKDIR /app
COPY ./ /app
RUN cargo build --target wasm32-unknown-unknown --release
RUN wasm-bindgen --out-dir ./web_gen/ --target web ./target/wasm32-unknown-unknown/release/lemmings.wasm

FROM nginx:alpine

COPY --from=build /app/web_gen/* /usr/share/nginx/html/
COPY web/* /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

