using System.IO;

using Amazon.Lambda.AspNetCoreServer;
using Microsoft.AspNetCore.Hosting;

var builder = WebApplication.CreateBuilder(args);

// builder.Services.AddControllers();
// builder.Services.AddControllersWithViews();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Register Lambda to replace Kestrel as the web server for the ASP.NET Core application.
// If the application is not running in Lambda then this method will do nothing. 
//builder.Services.AddAWSLambdaHosting(LambdaEntryPoint.HttpApi);
//builder.Services.AddAWSLambdaHosting(???);
var entryPoint = new LambdaEntryPoint();
builder.Services.AddSingleton(entryPoint);
// entryPoint.Init(builder); // NB: This is not public

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", () => "Hello World!");

app.Run();
