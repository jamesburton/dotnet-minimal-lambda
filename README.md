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
* Add Swagger including UI in `Program.cs` after initial .Build()
```
app.UseSwagger();
app.UseSwaggerUI();
```
* Add Swagger build config in `Program.cs` (before .Build()):
```
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
```
* Install libraries for AWS Lambda wrapper
    * `dotnet add package Amazon.Lambda.AspNetCoreServer.Hosting` 
* Modify `Program.cs` to add Lambda wrapper to builder:
```
// Register Lambda to replace Kestrel as the web server for the ASP.NET Core application.
// If the application is not running in Lambda then this method will do nothing. 
builder.Services.AddAWSLambdaHosting(LambdaEventSource.HttpApi);
```
* Add ports and tasks for certs, restore, build and watch-run task to .gitpod.yml
```
tasks:
  - name: Create dev certificate for HTTPS
    init: dotnet dev-certs https # NB: Could add `gp sync-done create-cert`
  - name: Build and watch-run aspnet application/API
    init: | # Could add `gp sync-await create-cert`
      dotnet restore
      dotnet build
    command: dotnet watch run

ports:
  - port: 5113 # HTTP
    onOpen: open-browser
```
* When you restart now the app should build and watch-run then open the browser.
* Swagger is available on `/swagger`, and the JSON is at `/swagger/v1/swagger.json`
* Now you can simply update functions in the `Program.cs` file.
    * NB: Detection runs at startup so if you add a new function you will need to stop the watch-run and restart with `dotnet watch run`
