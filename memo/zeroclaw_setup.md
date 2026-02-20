https://github.com/zeroclaw-labs/zeroclaw

Build and install:

```
cargo build --release
cargo install --path .
```

Edit the provider and the model name in ~/.zeroclaw/config.toml:

```
default_provider = "anthropic"
default_model = "claude-sonnet-4-6"
```

Run the agent with subscription auth:

```
ANTHROPIC_OAUTH_TOKEN=sk-ant-oat01-xxx zeroclaw agent
```

To get OAuth token:

```
claude setup-token
```

To make it a systemd service:

```
zeroclaw service install
zeroclaw service start
systemctl --user status zeroclaw
```

Edit the service file and add:

```
[Service]
Environment="ANTHROPIC_OAUTH_TOKEN=xxx"
```
