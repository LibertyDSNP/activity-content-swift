<a href="https://github.com/LibertyDSNP/activity-content-swift/actions">
  <img src="https://github.com/LibertyDSNP/activity-content-swift/actions/workflows/swift.yml/badge.svg" alt="Continuous Integration">
</a>

## Activity Content SDK

The Activity Content SDK is a library that supports converting DSNP Activity Content data to and from JSON.
For details on DSNP or Activity Content please see

**[Activity Content DSNP Spec 1.0][1]**

## Installation

### Swift Package Manager

1. From XCode, select File > Add Packages. Enter `https://github.com/LibertyDSNP/activity-content-swift` as the package URL.
2. Once the SDK has been added to your project, import using:

```swift
import ActivityContentSDK
```

## Usage

### Building Models from Scratch

The SDK providers `Builders` that allow you to create any of the objects specified in the **[Activity Content DSNP Spec 1.0][1]**.

```swift
// Builders
ActivityContent.Builders.Profile()
ActivityContent.Builders.Note()
ActivityContent.Builders.Hash()
ActivityContent.Builders.Location()
// Builders for Attachments
ActivityContent.Builders.Attachments.Audio()
ActivityContent.Builders.Attachments.AudioLink()
ActivityContent.Builders.Attachments.Image()
ActivityContent.Builders.Attachments.ImageLink()
ActivityContent.Builders.Attachments.Video()
ActivityContent.Builders.Attachments.VideoLink()
ActivityContent.Builders.Attachments.Link()
// Builders for Tags
ActivityContent.Builders.Tags.Mention()
ActivityContent.Builders.Tags.Hashtag()
```

Once you have initialized a Builder and assigned it's relative properties, call `build()` to return a usable model object.

Note that the `build()` method only returns objects that are considered valid by the specification. If the object is invalid, the method will throw a corresponding error.

#### Example

```swift
let note = try? ActivityContent.Builders.Note()
    .withName("Kilimanjaro two-horned chameleon")
    .withContent("A chameleon I came across in Marangu, Tanzania, East Africa.")
    .addAttachments([
        try? ActivityContent.Builders.Attachments.Video()
            .withName("Two-Horned Chameleon")
            .addVideoLinks([
                try? ActivityContent.Builders.Attachments.VideoLink()
                    .withHref(URL(string: "https://commons.wikimedia.org/wiki/File:Two-Horned_Chameleon.webm")!)
                    .withMediaType(.mp4)
                    .addHashes([
                        try? ActivityContent.Builders.Hash()
                            .withAlgorithm(.keccak)
                            .withValue("0x9da9ec7069ee6ad9f4e58929462db0f04f49034a356d1a36f631ce6457101bdd")
                            .build()
                    ])
                    .build()
            ])
            .build()
    ])
    .addTags([
        try? ActivityContent.Builders.Tags.Hashtag()
            .withName("#wild")
            .build(),
        try? ActivityContent.Builders.Tags.Mention()
            .withName("John Doe")
            .withDSNPUserId("dsnp://1234")
            .build()
    ])
    .withLocation(try? ActivityContent.Builders.Location()
                    .withName("Marangu, Tanzania, East Africa")
                    .withCoordinate(CLLocationCoordinate2D(latitude: -3.352831922, longitude: 37.519831254))
                    .build())
    .build()
```

### Building Models from JSON

Any of the Builder classes can also be used to build from a valid JSON string, using the initializer: `init?(json: String)`

Note that the initializer returns an optional. A Builder object will be returned only if the JSON is valid and is identifiable as the requested type.

#### Example

```swift
let json = """
    {
      "@context" : "https://www.w3.org/ns/activitystreams",
      "type" : "Note",
      "mediaType" : "text/plain",
      "content" : "A Sample Note"
    }
    """

let note = try? ActivityContent.Builders.Note(json: json)?.build()
```

### Converting Models to JSON

Any model can be converted to JSON by calling `.json` on the object.

#### Example

```swift
let note = try? ActivityContent.Builders.Note()
    .withContent("A Sample Note")
    .build()

let json = note?.json
```

### Support for Additional Fields

The SDK supports adding additional fields that are not defined in the [Activity Content Spec][1] (see [Additional Fields][2]).

#### Writing Additional Fields to JSON

When using Builders, each builder has access to a method called `addAdditionalFields(_ : [String : Any])`. There are a couple of things to note here:
1. The value must be `Codable`. Attempting to convert a non-codable value to JSON will result in an error.
2. If a value is added to additional fields whose key is shared by the model object itself, it will be ignored when converting to JSON.

Additional Fields can be accessed by calling the `.additionalFields` dictionary on the object. Note that it is the responsibility of the caller to cast the value to the desired type.

#### Example

```swift
let note = try? ActivityContent.Builders.Note()
    .withContent("A Sample Note")
    .addAdditionalFields([
      "custom_int" : 42,
      "custom_string" : "hello",
      "custom_array" : [true, false],
      "custom_dictionary" : ["pi" : 3.14159],
      "content" : "override" // `content` is reserved by the model and will be ignored when converting to JSON
    ])
    .build()
```

#### Reading Additional Fields from JSON

The `init?(json: String)` will automatically parse custom fields from the provided JSON string, and add them to the additionalFields property.

#### Example

```swift
let json = """
    {
      "@context" : "https://www.w3.org/ns/activitystreams",
      "type" : "Note",
      "mediaType" : "text/plain",
      "content" : "A Sample Note",
      "custom_int" : 42,
      "custom_string" : "hello"
    }
    """

let note = try? ActivityContent.Builders.Note(json: json)?.build()
let customInt = note?.additionalFields["custom_int"] as? Int // 42
let customString = note?.additionalFields["custom_string"] as? String // "hello"
```

## License

        Copyright 2022 Unfinished Labs LLC

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

[1]: https://spec.dsnp.org/ActivityContent/Overview
[2]: https://spec.dsnp.org/ActivityContent/Overview#additional-fields
