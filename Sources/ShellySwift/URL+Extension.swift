import Foundation

extension URL {
    
    /**
     Initialize a URL using specific file path
     */
    public init(_ filePath: String) {
        self.init(fileURLWithPath: filePath)
    }
    
    /**
     If the url is a directory
     */
    public var isDirectory: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return result.boolValue
    }
    
    /**
     If the url is a file
     */
    public var isFile: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return !result.boolValue
    }
    
    /**
     Get the URLs of files inside a directory
     
     - returns:
     An array including all the urls of files in the specific directory.
     
     - parameters:
        - includeHiddenFiles: Wether or not hidden files should be included in the result
     
     */
    public func subURLs(includeHiddenFiles: Bool = false) -> [URL] {
        guard self.isDirectory else { return [URL]() }
        var urls = [URL]()
        var options: FileManager.DirectoryEnumerationOptions = [.skipsSubdirectoryDescendants]
        if !includeHiddenFiles {
            options.insert(.skipsHiddenFiles)
        }
        guard let enumerator = FileManager.default.enumerator(at: self,includingPropertiesForKeys: nil, options: options) else { return [URL]() }
        while let fileURL = enumerator.nextObject() as? URL {
            urls.append(fileURL)
        }
        urls.sort { $0.lastPathComponent < $1.lastPathComponent } // sort URLs A-z
        return urls
    }
    
}
