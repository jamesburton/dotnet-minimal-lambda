# DotNet minimal lambdas

## References
* Minimal guide: https://pikedev.com/net-6-minimal-api-on-aws-lambda/
* Another minimal start: https://dotnetcoretutorials.com/2021/07/16/building-minimal-apis-in-net-6/
* With Swagger (see ASP.NET Core minimal APIs): https://aws.amazon.com/blogs/compute/introducing-the-net-6-runtime-for-aws-lambda/
* MS Docs: https://docs.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-6.0&tabs=visual-studio
* With JWT Auth: https://dotnetthoughts.net/minimal-api-in-aspnet-core-mvc6-part2/
* Another JWT Example: https://dev.to/moe23/net-6-minimal-api-authentication-jwt-with-swagger-and-open-api-2chh
* Using Cognito auth in ASP.NET: https://medium.com/onebyte-llc/authentication-and-authorization-using-cognito-in-asp-net-7bdedf176f8c
* AWS Guide to Cognito Auth: https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/cognito-apis-intro.html
* Cognito Auth Extensions: https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/cognito-authentication-extension.html

## Create

* `dotnet new web -o . -n dotnet-minimal-lambda`
* Install libraries for Swagger
    * `dotnet add package Swashbuckle.AspNetCore`
