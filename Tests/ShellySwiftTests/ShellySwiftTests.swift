import XCTest
@testable import ShellySwift

final class ShellySwiftTests: XCTestCase {
    
    func isFileOrDirectory() {
        let fileURL = URL("/System/Applications/App Store.app/Contents/version.plist")
        XCTAssertTrue(fileURL.isFile)
        XCTAssertFalse(fileURL.isDirectory)
        let dirURL = URL("~/Documents")
        XCTAssertFalse(dirURL.isFile)
        XCTAssertTrue(dirURL.isDirectory)
    }
    
    func subURLs() {
        let correctAnswers : [URL] = [
            URL("/System/Applications/App Store.app/Contents/_CodeSignature"),
            URL("/System/Applications/App Store.app/Contents/MacOS"),
            URL("/System/Applications/App Store.app/Contents/PlugIns"),
            URL("/System/Applications/App Store.app/Contents/Resources"),
            URL("/System/Applications/App Store.app/Contents/Info.plist"),
            URL("/System/Applications/App Store.app/Contents/PkgInfo"),
            URL("/System/Applications/App Store.app/Contents/version.plist"),
        ]
        let url = URL("/System/Applications/App Store.app/Contents")
        XCTAssertEqual(url.subURLs(includeHiddenFiles: false), correctAnswers)
    }

    static var allTests = [
        ("isFileOrDirectory", isFileOrDirectory),
        ("subURLs", subURLs)
    ]
}
