# CS188 - Scalable Internet Services
[![Build Status](https://travis-ci.org/scalableinternetservices/linksin.svg?branch=master)](https://travis-ci.org/scalableinternetservices/linksin)

* Section Time: Friday 2PM - 3:50PM

* Team Name: LinksIn

* Team Members
<table>
 <tr>
  <td>Amy Tu</td>
  <td>Junhong Wang</td>
  <td>Omar Tleimat </td>
  <td>Cheuk Yin Phipson Lee</td>
 </tr>
 <tr>
  <td><img src="team/amys_photo.jpg" width="128"></td>
  <td><img src="team/junhong.jpg" width="128"></td>
  <td><img src="team/omars_photo.jpg" width="128"></td>
  <td><img src="team/phipson.jpg" width="128"></td>
 </tr>
</table>

# Demo
[![Demo](./demo.gif)](https://www.youtube.com/watch?v=6Hr1A5NWLPY)

# Results
- [Report](./report.pdf)
- [Presentation](./presentation.pdf)

# Description
<p align="center">
 <img src="team/logo.svg" width="512">
</p>
LinksIn is a social networking app that builds upon the mechanics of networking on Tinder to create an accessible, sociable media outlet for the gaming community. As gamers, users can connect to LinksIn through their existing gaming accounts, swipe through other gamers and players using the Tinder card-swiping mechanism, and connect with new players that might be in the same game as them. Additionally, with LinksIn, players can also create LAN events and invite people within their 'card community' to join and coordinate gaming events together.

# Development
1. Clone this repository
```Bash
git clone https://github.com/scalableinternetservices/linksin.git
```
2. Change directory to linksin
```Bash
cd ./linksin
```
3. Install all dependencies
```Bash
yarn install
```
4. Install all gems
```Bash
bundle install
```
5. Initialize the database
```Bash
rails db:migrate
```
6. Seed the database with some fake users
```Bash
rails db:seed
```
7. start the server
```Bash
rails server
```
8. Go to [localhost:3000](http://localhost:3000/)

# Deployment
1. SSH into AWS server
```Bash
ssh -i ~/.ssh/linksin.pem linksin@ec2-34-209-211-32.us-west-2.compute.amazonaws.com
```
2. Clone this repository
```Bash
git clone https://github.com/scalableinternetservices/linksin.git
```
3. Change directory to linksin
```Bash
cd ./linksin
```
4. Initialize AWS Elastic Beanstalk instance
```Bash
eb init
```
5. Deploy
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --single 
```
6. Go to [AWS console](https://273020147241.signin.aws.amazon.com/console) to check deployment status

# Load Testing
## How to run test script
1. Go to [AWS console](https://273020147241.signin.aws.amazon.com/console)
2. Go to CloudFormation and create a stack with following S3 URL
```
https://ucla-cs188-fall-2019.s3.amazonaws.com/Tsung.json
```
3. Click Output tab and ssh into the stack
4. Install git on the stack
```Bash
sudo yum install git
```
5. Clone this repo
```Bash
git clone https://github.com/scalableinternetservices/linksin.git
```
6. Make sure the xml files are pointing to the correct URL
7. Prepare for testing
```Bash
tsung -kf signup.xml start
```
8. Run testing script
```Bash
tsung -kf critical.xml start
```
9. Create plots from tsung log
```Bash
tsplot "First test" firsttest/tsung.log -d outputdir
```
You can also plot two or more logs on the same graph
```Bash
tsplot "First test" firsttest/tsung.log "Second test" secondtest/tsung.log -d outputdir
```
10. Transfer testing result to local machine
```Bash
scp -r -i ~/.ssh/linksin.pem ec2-user@remove_ip_address:your_tsung_log_path_in_remote destination_path_in_your_local_machine
```
11. Check graphes-Transactions-mean.csv for response time data
12. Check page_mean.png for response time graph

## How to write test script
1. Download [Firefox](https://www.mozilla.org/en-US/firefox/)
2. [Set the manual proxy](https://support.mozilla.org/en-US/kb/connection-settings-firefox) to host: 127.0.0.1 and port: 8090
3. Install tsung locally
```Bash
brew install tsung
```
4. Install tsung dependency (maybe unnecessary)
```Bash
sudo cpan Template
```
5. Run tsung-recorder
```Bash
tsung-recorder -p http start -L 8090
```
6. Use Firefox to access [linksin deployment website](http://linksin-dev.us-west-2.elasticbeanstalk.com) and perform tasks you want to turn into scripts
7. Stop tsung recorder
```Bash
tsung-recorder stop
```
8. Check the file generated by the recorder and use it as a reference for writing your test script

## Vertical Sacling
1. t3-large
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.large --single 
```
2. t3-xlarge
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.xlarge --single 
```
3. t3-2xlarge
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.2xlarge --single 
```
4. m4-4xlarge
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type m4.4xlarge --single 
```
5. m4-16xlarge
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type m4.16xlarge --single 
```
6. Check [this](https://aws.amazon.com/ec2/instance-types/) for different instance

## Horizontal Scaling
1. 2 instances of t3-micro
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --scale 2
```
2. 4 instances of t3-micro
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --scale 4
```
3. 8 instances of t3-micro
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --scale 8
```
4. 16 instances of t3-micro
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --scale 16
```
5. 32 instances of t3-micro
```Bash
eb create -db.engine postgres -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin --instance_type t3.micro --scale 32
```
6. Check [this](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb3-create.html) for eb create documentation

## Performance Optimization with processes/thereads
Setup ebextension to override default puma.rb EC2 provides
1. 1 process & 1 thread
2. 8 processes & 1 thread
3. 1 process & 8 threads
4. 8 processes & 8 threads

## Read-slave
We will be doing 1 master & 1 read slave for simplicity
1. Follow the tutorial [here](https://guides.rubyonrails.org/active_record_multiple_databases.html) to make rails perform database read operations from read-slave.
2. For now, use placeholder for read-slave host name (We will create read slave database on AWS after deployment)
3. Deploy the application (Check the name of the database created)
4. Go to [AWS RDS Console](https://us-west-2.console.aws.amazon.com/rds/home?region=us-west-2) and search for the database of the deployed application
5. Go to top right section and click "create read replica"
6. Wait for a while until the replicated database is available
7. Use the endpoint of replicated database as the hostname of the read-slave (update config/puma.rb)
8. Redeploy the application

# Documentation
## Scrum Story
* As a gamer, I want to be able to link my accounts from the games I play, such as Steam, Blizzard, Gmail, League, Nintendo, in order to show people what games I play, and also directly add people as friends through these gaming accounts.

* As a gamer, I want to be able to share a description of the games I play, and what people I would be interested in playing with, in order to find gamers to play with, and also have gamers invite me.

* As a gamer, I want to host LAN events that can be viewed by people I have connected with, and also attend LAN events that are hosted by people in my network, in order to play games with everyone.

* As a gamer, when I log in, I want to be directed to the ‘card page’ where I can swipe through players, in order to filter through the players I may or may not be interested in playing with.

* As a gamer, I want to be able to filter my search results based on the games I play, the frequency at which players play these games, and the level of experience players have with these games, in order to specify the type of people I want to connect with.

## Design
* Logo 
<img src="team/logo.png" width="128">

* [LinksIn Color Pallete](https://colorhunt.co/palette/17117) 
<img src="team/pallete.png" width="128">

* [Bulma](https://bulma.io)
