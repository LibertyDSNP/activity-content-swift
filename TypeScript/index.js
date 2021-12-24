const activityContent = require("@dsnp/activity-content")
const hashtag = activityContent.factories.createHashtag("Earth")
console.log(hashtag)
const hashtag2 = activityContent.factories.createHashtag("#Earth")
console.log(hashtag2)

// including href in options overrides first param (href) in createLinkAttachment
// can add any set of params in options
const options = {"name" : "Link Name", "misc" : true}
const linkAttachment = activityContent.factories.createLinkAttachment("https://www.example.com", options)
console.log(linkAttachment)

const location = activityContent.factories.createLocation("Place Name")
console.log(location)

// validation test
const validProfile = {
  "@context": "https://www.w3.org/ns/activitystreams",
  type: "Profile",
  name: "jaboukie",
  icon: [
            {
              type: "Link",
              href: "https://pbs.twimg.com/profile_images/847818629840228354/VXyQHfn0_400x400.jpg",
              mediaType: "image/jpeg",
              hash: [
                {
                  algorithm: "keccak256",
                  value:
                    "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7",
                },
              ],
            },
          ],
  attachment: [
    {
      type: "Image",
      url: [
        {
          type: "Link",
          href: "https://upload.wikimedia.org/wikipedia/commons/a/ae/Mccourt.jpg",
          mediaType: "image/jpeg",
          hash: [
            {
              algorithm: "keccak256",
              value:
                "0x90b3b09658ec527d679c2de983b5720f6e12670724f7e227e5c360a3510b4cb5",
            },
          ],
        },
      ],
    },
  ],
};

const isValid = activityContent.validation.isActivityContentProfileType(validProfile)
console.log(isValid)
