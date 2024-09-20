# TrustedForm iOS Demo

This repository contains a demo project for integrating and demonstrating the functionality of the TrustedForm SDK on iOS. The TrustedForm SDK allows iOS developers to easily integrate TrustedForm's capabilities into their applications.

## Prerequisites

Before you begin, ensure you have the following installed:
- Xcode (latest version recommended)
- Swift Package Manager (comes with Xcode)
- An active iOS Developer account for running the demo on a physical device (optional)

## Getting Started

Follow these steps to set up and run the TrustedForm iOS demo project:

### 1. Clone the Repository

Start by cloning the repository to your local machine. You can do this by opening a terminal and running the following command:

```bash
git clone https://github.com/activeprospect/trustedform-ios-demo.git
```


### 2. Configure Development Settings

Navigate to the cloned repository directory and update the `development.xcconfig` file with your correct information. If you do not have personal credentials yet or wish to test the integration first, you can use our provided demo token.

```plaintext
// Inside development.xcconfig
DEMO_TOKEN = your_demo_token_here
```

### 3. Set TrustedForm SDK Version

Open your project in Xcode and use the Swift Package Manager to target the correct version of the TrustedForm SDK. As of this writing, the current version is `0.4.0`. To do this:

- Go to `File` > `Swift Packages` > `Add Package Dependency...`
- Enter the TrustedForm SDK repository URL (https://github.com/activeprospect/trustedform-ios-sdk)
- Choose version `0.4.0` and add the package to your project

### 4. Build and Run the Project

Finally, build and run the project in Xcode to see the TrustedForm iOS demo in action. You can run the project on a simulator or a physical device (if you have set up a developer account and a device for development).

## Support

For issues, questions, please open an issue or pull request in this repository. For more detailed documentation on the TrustedForm SDK, visit [TrustedForm SDK Documentation](https://github.com/activeprospect/trustedform-ios-sdk).

