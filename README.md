# OpenAISPM

  

## Swift Package Manager

  

You can use Swift Package Manager to integrate the library by adding the following dependency in the Package.swift file or by adding it directly within Xcode.

  

.Package(url: "https://github.com/jghg02/OpenAISPM")

  

## Usage

  
```swift
Import OpenAISPM
```

You need create a OpenAI API Key in this [link](https://platform.openai.com/account/api-keys) is very important to use when I create an instance for the class **OpenAIAPI**
```swift
let openAIAPI = OpenAIAPI(apiKey: "YOUR_API_KEY")
let result = try! await openAIAPI.sendMessage(text: "Your message here")
```

The `result` contain the response you get from OpenAI.  

