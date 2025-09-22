# Install just: https://github.com/casey/just#installation

# Default task (run with `just`)
default:
    just --list

# Update Flutter/Dart dependencies
bootstrap:
    flutter pub get

# Run the app in debug mode
dev:
    flutter run

# Remove build artifacts
clean:
    flutter clean
    just bootstrap

# Build for macOS
build-mac:
    flutter build macos --release

# Build for Windows
build-windows:
    flutter build windows --release

# Build for Linux
build-linux:
    flutter build linux --release

# Build for all desktop platforms
build-all:
    just build-mac
    just build-windows
    just build-linux

# Run tests
test:
    flutter test