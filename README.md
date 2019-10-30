This is the control repo used automatically by [IaC-Heat-A](https://gitlab.com/erikhje/iac-heat-a) on deployment.

We all edit files from Johan's setup using vscode live share, so he will have a vast majority of commits ;)

# Testing

## Unit testing
To run the unit tests, simply cd into site-modules/profile/ and run rake.

````
cd site-module/profile
rake spec
````

## Acceptance testing
To run the acceptance tests you will have to add some lines to your ssh configuration file.

````
vi ~/.ssh/config

````

And add the following.

````
Host balancer01.iac
     HostName <ip to machine>
     User root
     Port 22
     IdentityFile <path to private key>
Host database01.iac
     HostName <ip to machine>
     User root
     Port 22
     IdentityFile <path to private key>
Host frontend00.iac
     HostName <ip to machine>
     User root
     Port 22     
     IdentityFile <path to private key>
````

When the ssh-config is ready, simply cd into the root directory of the control repo and run rake.

````
rake spec
````