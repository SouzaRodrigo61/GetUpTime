# GetUpTime - iOS Application

## Overview

GetUpTime is an iOS application designed to promote healthy work habits by reminding users to take breaks from prolonged sitting. The app notifies users to stand up, walk, stretch, and more, based on customizable or medically recommended intervals. The goal is to encourage regular movement, contributing to better health and well-being.

## Features

- **Customizable Notifications:** Users can choose the type of reminder (e.g., stand up, walk, stretch) and set the frequency for notifications.
- **Medical Recommendations:** Predefined intervals based on medical guidelines ensure that users are prompted to take breaks at optimal times.
- **Fixed Walking Time:** Notifications to walk are set to a medically recommended duration and cannot be changed by the user.
- **Simple and Intuitive Interface:** The app features a clean and easy-to-understand design, making it accessible to all users.
- **Sound Alerts:** Notifications include sound to ensure users are alerted even if they are away from their device.

## Installation

### Prerequisites

- **macOS** with the latest version of **Xcode** installed.
- **Tuist** installed. If not installed, you can install it using the following command:

   ```bash
    brew tap tuist/tuist
    brew install tuist
   ```

### Setup

1. **Get Packages:**

   ```bash
   tuist install
   ```

2. **Generate the Xcode Project:**

   Use Tuist to generate the Xcode project files:

   ```bash
   tuist generate
   ```

   This will automatically resolve dependencies via Swift Package Manager (SPM) and set up the project.

3. **Open the Project:**

   After generating the project, open it in Xcode:

   ```bash
   open GetUpTime.xcodeproj
   ```

4. **Build and Run:**

   Select your target device or simulator in Xcode and press `Cmd + R` to build and run the project.

## Usage

- Upon launching the app, users will be prompted to set their notification preferences, such as the type of reminders and the frequency.
- The app will then run in the background, sending notifications with sound alerts to remind users to take action based on their preferences.
- The user can revisit the settings at any time to adjust the notification preferences.

## Contributing

We welcome contributions to improve GetUpTime. Please fork the repository and submit a pull request for any changes you would like to propose.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact

If you have any questions or need further assistance, please feel free to open an issue or contact us directly.
