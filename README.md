# Telesign

![Swift](http://img.shields.io/badge/swift-5.2-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)

### Telesign is a Vapor helper to use [TelesignKit](https://github.com/vapor-community/telesign-kit)

## Usage guide
In your `Package.swift` file, add the following.

~~~~swift
.package(url: "https://github.com/vapor-community/telesign.git", from: "1.0.0")
~~~~

To use Telesign in your Vapor application, set the environment variable for you API key and Customer ID.

~~~
export TELESIGN_API_KEY="my_api_key"
export TELESIGN_CUSTOMER_ID="my_customer_id"
~~~

Now you can access a `TelesignClient` via `Request` or `Application`.

~~~~swift
func sendSMS(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return req.telesign.messaging.send(phoneNumber: "1234567890",
                                       message: "Hello Vapor!",
                                       messageType: .ARN,
                                       accountLifecycleEvent: nil,
                                       senderId: nil,
                                       externalId: nil,
                                       originatingIp: nil).transform(to: .ok)
}
~~~~
