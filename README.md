Ruby version: 3.3.8

Dependencies (ubuntu):
```shell
sudo apt update
sudo apt install -y pkg-config libsqlite3-dev build-essential
sudo apt install chromium-driver
```

Run locally: `bundle install` then `rails server`

Tests: `rake test:run` and `rake test:system`

TODO:
- Swap out Clearance for default Rails 8 auth
  - Remove rspec
  - Remove clearance
  - Make auth work well
- List features needed for first public version

Tile graphics: [FluffyStuff/riichi-mahjong-tiles](https://github.com/FluffyStuff/riichi-mahjong-tiles)