import json
from django.http import HttpResponse
import requests
from urllib.parse import unquote
import urllib.request
from urllib.parse import urlparse
import boto3

try:
    from urllib import request
except ImportError:
    import urllib
    
s3 = boto3.client('s3')

def lambda_handler(event, context):
    query = event['queryStringParameters']
    if len(query) == 0:
        welcome = """

<html lang="en">
  <head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<body class="bg-dark">
<div class="container h-100">
            <div class="row h-100 justify-content-center align-items-center">
                <div class="col-10 col-md-8 col-lg-6">
                  <div class="form-group">
<form class="form-control" action="?" method="GET">
  <input type="text" id="url" name="url"  class="form-control" >
  <br>
  <input type="submit" class="btn btn-warning btn-sm btn-block" value="Download">
</form> 
</div>
</div>
</div>
</div>


</body>
</html>
        """    
        return {
        'statusCode': 200, 
        'headers': {"Content-Type":"text/html"},
        'body': welcome
        }
    else:
        Url = query['url']
        print(Url)
        print(unquote(Url))
        url = unquote(Url)
                
        req = urllib.request.Request(
            url, 
            data=None, 
            headers={
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'
               }
        )
                
        response = request.urlopen(req)
        XML = response.read()
        XML = XML.decode("UTF-8")
        urlp = urlparse(url)
        s3.put_object(Bucket='slinkistaskbucketlambda', Key=urlp.netloc+'.xml', Body=XML)
        
        return {
        'statusCode': 200, 
        'headers': {"Content-Type":"text/html"},
        'body': url+" downloaded"
        }