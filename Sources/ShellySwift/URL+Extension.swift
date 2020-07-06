import Foundation

extension URL {
    
    init(_ filePath: String) {
        self.init(fileURLWithPath: filePath)
    }
    
    public var isDirectory: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return result.boolValue
    }
    
    public var isFile: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return !result.boolValue
    }
    
    public func subURLs(includeHiddenFiles: Bool) -> [URL] {
        var urls = [URL]()
        var options: FileManager.DirectoryEnumerationOptions
        if includeHiddenFiles {
            options = [
                .skipsHiddenFiles,
                .skipsPackageDescendants,
                .skipsSubdirectoryDescendants,
            ]
        } else {
            options = [
                .skipsPackageDescendants,
                .skipsSubdirectoryDescendants,
            ]
        }
        guard let enumerator = FileManager.default.enumerator(at: self,includingPropertiesForKeys: nil, options: options) else { return [URL]() }
        while let fileURL = enumerator.nextObject() as? URL {
            urls.append(fileURL)
        }
        urls.sort { $0.lastPathComponent < $1.lastPathComponent } // sort URLs A-z
        return urls
    }
    
}
