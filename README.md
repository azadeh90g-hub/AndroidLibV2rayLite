# 🎨 AndroidLibV2rayLite

## About

AndroidLibV2rayLite is a lightweight Go library designed to embed V2Ray's core functionalities into Android applications. It provides a simple, accessible interface for developers to integrate V2Ray without needing to manage the complexities of the core engine. This library is ideal for creating privacy-focused apps, custom VPN clients, or any application requiring secure, flexible network proxying capabilities.

## Prerequisites

Before you begin, ensure you have the following tools installed and configured in your development environment:

- **Go (Golang):** Version 1.18 or higher.
- **Java Development Kit (JDK):** Version 11 or higher.
- **Android SDK:** API level 21 or higher.
- **Gomobile:** The Go tool for building mobile applications.

*You can install Gomobile by running:*
`go install golang.org/x/mobile/cmd/gomobile@latest`

## Quickstart Guide

Follow these steps to build the library from the source and integrate it into your project:

1. **Clone the Repository:**
   Clone this repository to your local machine.

2. **Initialize Gomobile:**
   `gomobile init`

3. **Tidy Go Modules:**
   `go mod tidy -v`

4. **Build the Android Archive (AAR):**
   `gomobile bind -v -androidapi 21 -ldflags='-s -w' ./`

This will generate an `.aar` file that you can include in your Android project's `libs` directory.

## Contributing

Contributions from the community are welcome! To ensure a smooth and collaborative process, please follow these guidelines:

- **Bug Reports:** When reporting a bug, please provide a detailed description of the issue, steps to reproduce it, and your environment setup.
- **Feature Requests:** For new features, open an issue to discuss the idea before submitting a pull request.
- **Code Style:** Please follow standard Go formatting and conventions. Run `gofmt` on your code before committing.
- **Pull Requests:** All pull requests should be well-documented with a clear explanation of the changes and their purpose.

Thank you for helping to improve AndroidLibV2rayLite!
