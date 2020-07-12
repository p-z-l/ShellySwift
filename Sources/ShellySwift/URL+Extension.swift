import Foundation

extension URL {
    
    /**
     Initialize a URL using specific file path
     */
    public init(_ filePath: String) {
        self.init(fileURLWithPath: filePath)
    }
    
    /**
     If the URL targets to a directory
     */
    public var isDirectory: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return result.boolValue
    }
    
    /**
     If the URL targets to a plain text file
     */
    var isPlainTextFile: Bool {
        do {
            let _ = try String(contentsOf: self)
            return true
        } catch {
            return false
        }
    }
    
    /**
     If the URL targets to a file
     */
    public var isFile: Bool {
        var result : ObjCBool = false
        FileManager.default.fileExists(atPath: self.path, isDirectory: &result)
        return !result.boolValue
    }
    
    /**
     A convenience call of `self.subURLs()`
     */
    public var subURLs: [URL] {
        return self.subURLs()
    }
    
    /**
     The level of the URL, returns 0 in the case of a remote URL
     */
    public var level: Int {
        return self.pathComponents.count
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
    
    /**
     Returns a Boolean value indicating whether the path components of the first argument is more than that of the second argument.
     
     - parameters:
        - lhs: A value to compare.
        - rhs: Another value to compare.
     */
    static public func >(lhs: URL, rhs: URL) -> Bool {
        return lhs.level > rhs.level
    }
    
    /**
     Returns a Boolean value indicating whether the path components of the first argument is less than that of the second argument.
     
     - parameters:
        - lhs: A value to compare.
        - rhs: Another value to compare.
     */
    static public func <(lhs: URL, rhs: URL) -> Bool {
        return lhs.level < rhs.level
    }
    
    /**
     Returns a Boolean value indicating whether the two URLs have the same amount of path components
     
     - parameters:
        - lhs: A value to compare.
        - rhs: Another value to compare.
     */
    static public func ==(lhs: URL, rhs: URL) -> Bool {
        return lhs.level == rhs.level
    }
    
    /**
     Returns a Boolean value indicating whether the path components of the first argument is more than or equal to that of the second argument.
     
     - parameters:
        - lhs: A value to compare.
        - rhs: Another value to compare.
     */
    static public func >=(lhs: URL, rhs: URL) -> Bool {
        return lhs.level >= rhs.level
    }
    
    /**
     Returns a Boolean value indicating whether the path components of the first argument is less than or equal to that of the second argument.
     
     - parameters:
        - lhs: A value to compare.
        - rhs: Another value to compare.
     */
    static public func <=(lhs: URL, rhs: URL) -> Bool {
        return lhs.level <= rhs.level
    }
}
