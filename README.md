# Requirements

* iOS 11
* Xcode 9.3

# Build instructions

Install [Bundler](http://bundler.io)

```bash
gem install bundler
```

Run

```bash
bundle install
bundle exec pod install
```

# Assumptions

1. To add a new location just long-press on a map and press "Save Location".
1. To view the location info tap on a marker and press "Details".
1. App shows distance to the location only if user enabled location services.
1. Default locations are fetched from a predefined URL only once. After that they are stored on a device so user can update them as he wants in a future.