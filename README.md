# Puppet Control Repo

This is project developed for our Infrastructure as Code project. It automates the deployment of a Golang REST API, which uses a PostgreSQL database. Changes to the Golang repository triggers automatic rebuilds and redeploys the API. It uses this [example Golang REST API](https://github.com/ErlendF/test-rest) to demonstrate connectivity, aswell as read and write access to the database. This can be changed in Hiera.


The repository automatically used by [IaC-Heat](https://github.com/ErlendF/IaC-Heat) on deployment. 


*The project is based on [this puppet control repo by Erik Hjelmås](https://gitlab.com/erikhje/control-repo-a), which in turn is based on [this puppet control repo template by puppetlabs](https://github.com/puppetlabs/control-repo).*


## Brief structure

Each of the nodes are assigned a *role* (see manifests/site.pp). Each *role* consists of several *profiles* which provide various functionality.


A Telegraf, InfluxDB, Grafana stack is used for monitoring.

## Testing
For unit testing we use rspec-puppet. For acceptance testing we use Serverspec.

### Unit testing
To run the unit tests, simply cd into site-modules/profile/ and run rake.

````
cd site-module/profile
rake spec
````

### Acceptance testing
To run the acceptance tests you will have to add some lines to your ssh configuration file.

````
vi ~/.ssh/config

````

And add the following (note that the Host-field should match the hosts variable in the Rakefile):

````
Host balancer01.iac
     HostName <ip to machine>
     User ubuntu
     Port 22
     IdentityFile <path to private key>
Host database01.iac
     HostName <ip to machine>
     User ubuntu
     Port 22
     IdentityFile <path to private key>
Host frontend00.iac
     HostName <ip to machine>
     User ubuntu
     Port 22     
     IdentityFile <path to private key>
````

When the ssh-config is ready, simply cd into the root directory of the control repo and run rake.

````
rake spec
````

### Authors
Johan Selnes, Aksel Baardsen, Erlend Fonnes

*During the project, we used [Vscode liveshare](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare), which is why Johan likely has the majority of our commits.*