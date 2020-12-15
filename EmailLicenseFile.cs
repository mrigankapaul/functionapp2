using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using SendGrid.Helpers.Mail;

namespace functionapp2
{
    public static class EmailLicenseFile
    {
        [FunctionName("EmailLicenseFile")]  
        public static void Run([BlobTrigger("licenses/{name}", Connection = "AzureWebJobsStorage")]string licenseFileContent,
        [SendGrid(ApiKey = "SendGridApiKey")] out SendGridMessage message,
        string name, 
        ILogger log)
        {   var email =  "paul.mriganka@gmail.com";
            log.LogInformation($"Got Order from {email}\n. License File Name: {name}");
            message = new SendGridMessage();
            message.From = new EmailAddress(Environment.GetEnvironmentVariable("EmailSender"));
            message.AddTo(email);
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(licenseFileContent);
            var base64 = Convert.ToBase64String(plainTextBytes);
            message.AddAttachment(name, base64, "text/plain");
            message.Subject = "Your license file";
            message.HtmlContent = "Thank you for your order";
        }
    }
}
