import Foundation

extension URL {
    
    /**
     Initialize a URL using specific file path
     */
    public init(_ filePath: String) {
        self.init(fileURLWithPath: filePath)
    }
    
    /**
     If the url targets to a directory
     */
    public var isDirectory: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return result.boolValue
    }
    
    /**
     If the url targets to a file
     */
    public var isFile: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return !result.boolValue
    }
    
    /**
     The content of the target file as String
     
     - returns:
        The content of the target file as String, returns nil if the URL does not exist or the target file is not a plain-text file
     
     - parameters:
         - encoding: The encoding used for encode the file
     */
    public func contentString(encoding: String.Encoding = .utf8) -> String? {
        return try? String(contentsOf: self, encoding: encoding)
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
