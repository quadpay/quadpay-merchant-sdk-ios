# QuadPaySDK Secret Keys

## Problem
The QuadPaySDK is built as a library, not an executable, to consumed and used in a 3rd party iOS application. This enables anyone who wan't to integration Zip as a payment option in their mobile iOS app the ability to do so.

Various services could be used by the QuadPaySDK pod that is generated using [CocoaPods](https://cocoapods.org/pods/QuadPaySDK), and these services may require API keys for our application to perform as we expect. One of those services is Segment, who we use for analytics, and it requires an API key for Zip. There is a need to store that API key securely, not in plain text in the `.podspec` or in source control.

## Solution
CocoaPods Keys is a CocoaPods plugin that provides the ability to use Apple's KeyChain technology to hash the secret and create a pod that our QuadPaySDK can use to access the keys. 

Per Apple, there is no absolute secure way to store keys in any mobile application, as the application runs on the client, and the client can set up debuggers to discover keys. The point of this solution is to not openly store the keys in our public source code repository.

## Usage
The following details should guide any MacOS user to modify or create the keys using CocoaPods Keys.

### Installing Ruby and Dependencies (Gems)
MacOS natively comes with Ruby, but it'll require permission to create the keys, which ends up becoming difficult. The solution to this is to install Ruby on the user level using `rbenv`.

Install with Homebrew using the instructions [here](https://github.com/rbenv/rbenv#homebrew).
>To override MacOS' Ruby version, you may need to open your `~/.zshrc` file and add the new version to your `PATH`.
>```bash
># Override Ruby version with rbenv
>if [ -d "/Users/{you user name}/.rbenv/versions/3.1.2/bin" ]; then
>  export PATH=/Users/{you user name}/.rbenv/versions/3.1.2/bin:$PATH
>  export PATH=`gem environment gemdir`/bin:$PATH
>fi
>```
>Then apply the changes
>```bash
>source ~/.zshrc
>```

Next, you will need to install the gems for CocoaPods and CocoaPods-Keys.

```bash
gem install cocoapods

gem install cocoapods-keys
```

### Adding/Updating Key
From the root of the repo, add your key's name to the array of keys defined in the `Podfile`

```ruby
plugin 'cocoapods-keys', {
  :project => 'QuadPaySDK',
  :keys => [
    'SegmentWriteKey',
    'MyNewKey'
  ]
}
```

Then running `pod install` will prompt for the keys not yet set. If it asks you for a project, provide `QuadPaySDK`. This will depict the name of the file generated and a custom store location for the keys.

This install will generate a pod that contains the `.h` and `.m` file for the keys. These are the interface header and class implementation of the keys. These files need to be pulled into the SDK, rather than importing the pod into the SDK. The reason for this is because we will not deploy this pod for usage when the 3rd party app installs our SDK, so the keys need to exist within the SDK itself.

Simply replace the files in `./QuadPaySDK` with the generated files. Sometimes Xcode will remove the header file from the public headers, so if that happens, just add the `QuadPaySDKKeys.h` header as a public header in the project settings under the Build Phases/Headers setting location.

You can access the key value by using the interface
```swift
let keys = QuadPaySDKKeys()
let myNewKeyValue = keys.myNewKey
```
