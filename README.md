# SwiftChan
go-like swift channel implementation 

Usage
-----

```swift
let channel = SwiftChan<Int>()

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
    let result = computeComplexResult()
    if result != -1 {
        channel.send(result)
    }
    else {
        channel.send(error: NSError(domain: "com.complexresult.error", code: 0, userInfo: nil)
    }
})

do {
    let result = try channel.recv() // lock current thread until complex result is ready...
    print(result)
}
catch let error as NSError {
    // handle "com.complexresult.error" here...
}
```
