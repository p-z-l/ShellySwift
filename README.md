# ShellySwift

File operations for Swift made easier.

## Install:
Swift Package: `https://github.com/p-z-l/ShellySwift.git`

## How to use:

```Swift
import ShellySwift

// Make sure ShellySwift has been correctly installed
ShellySwift.helloWorld()

// Initialize a URL
let url = URL("~/Documents")

// Know if a URL is file or directory:
if url.isFile {
    print("It's a file")
} else if url.isDirectory {
    // Get the subdirectory URLs of a URL:
    for url in url.subURLs() {
        print(url.lastPathComponent)
    }
}
```
