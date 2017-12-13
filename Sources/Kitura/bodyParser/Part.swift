/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

// MARK Part

/**
A part of a parsed multi-part form body.
### Usage Example: ###
In this example, the request body is parsed and split into multiple parts. The parts are then iterated through and for each `Part` the server responds with its name, filename and body.
```swift
router.post("/example") { request, response, next in
    let body = request.body
    let parts = body.asMultiPart
    for part in parts {
        response.send("\(part.name) \(part.filename) \(part.body) ")
    }
}
```
*/
public struct Part {

    /// The name attribute of the part.
    public internal(set) var name = ""

    /// The filename attribute of the part.
    public internal(set) var filename = ""

    /// Content type of the data in the part.
    public internal(set) var type = "text/plain"

    /// A dictionary of the headers: Content-Type, Content-Disposition, 
    /// Content-Transfer-Encoding.
    public internal(set) var headers = [HeaderType: String]()

    /// The contents of the part.
    public internal(set) var body: ParsedBody = .raw(Data())

    /** Possible header types that can be found in a part of multi-part body.
    ### Usage Example: ###
    In this example an instance on the `Part` class called part has the .disposition value of its headers field set to equal "inline".
    ```swift
    part.headers[.disposition] = "inline"
    ```
    */
    public enum HeaderType {

        /// A Content-Disposition header (multipart/form-data bodies).
        case disposition

        /// A Content-Type header (multipart/form-data bodies).
        case type

        /// A Content-Transfer-Encoding header (multipart/form-data bodies).
        case transferEncoding

        /// A Content-Range header (multipart/byteranges bodies).
        case contentRange
    }
}
