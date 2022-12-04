
import time
import hashlib
import subprocess as sp
from urllib.error import HTTPError, URLError
from urllib.request import urlopen, Request
import platform
from pythonping import ping
import sys
import pyfiglet

ascii_banner = pyfiglet.figlet_format("Health Check")
print(ascii_banner)

print("""\nThis script will monitor the server and the website for changes. If the page is defaced or changed 
the resulting Hash will be different and you will see an alert on screen. The script will also periodically 
ping the server and display the RTT and IP address on screen.\n""")

try:
    site_url = sp.getoutput('terraform output -raw hello_world_link')
    site_url_formatted= "http://" + site_url + "/index.html"
    ip_address = sp.getoutput('terraform output -raw EC2_Instance_IP')
    
    if site_url:
        print("\n\033[1;30;42m Got Site URL and EC2 Instance IP, Proceeding: \033[0;0m \n ")
        print("\n DNS Hostname:\033[5;30;42m %s \033[0;0m" % site_url)
        print("\n Server IP:\033[5;30;42m %s \033[0;0m" % ip_address)
        
        url = Request(site_url_formatted,
            headers={'User-Agent': 'Mozilla/5.0'})

        # to perform a GET request and load the
        # content of the website and store it in a var
        response = urlopen(url).read()
        
except (ValueError, NameError):
    print("\nError! Unable to query Terraform output for website URL and server IP. Have you deployed the infrastructure?\n") 
    exit()   

# to create the initial hash
currentHash = hashlib.sha224(response).hexdigest()

time.sleep(10)
while True:
    try:
        print("-" * 50)
        print("Pinging the server:")
        ping(ip_address, count=1, verbose=True)
        print("-" * 50)
        
        # perform the get request and store it in a var
        response = urlopen(url).read()
        
        # create initial hash
        currentHash = hashlib.sha224(response).hexdigest()
        
        #Set Sleep Duration
        time.sleep(20)
 
        # perform the get request
        response = urlopen(url).read()
    
        # create a new hash
        newHash = hashlib.sha224(response).hexdigest()
 
        # check if new hash is same as the previous hash
        if newHash == currentHash:
            print("-" * 50)
            print("\033[1;30;42m No changes to the hash value detected \033[0;0m\n")
            print("-" * 50)
            continue
 
        # If the Hash changes
        else:
            # notify
            print("-" * 50)
            print("\033[1;30;41m Hash has changed, check the site for defacement or other changes \033[0;0m\n")
            print("-" * 50)
 
            response = urlopen(url).read()
 
            # create a Hash for the next comparison
            currentHash = hashlib.sha224(response).hexdigest()
 
            #Set Sleep Duration
            time.sleep(10)
            continue
 
    # handle exceptions
    except Exception as e:
        print(e)
    except KeyboardInterrupt:
        print("Exiting Script")
        sys.exit()
