# CS188 - Scalable Internet Services
[![Build Status](https://travis-ci.org/scalableinternetservices/linksin.png?branch=master)](https://travis-ci.org/scalableinternetservices/linksin)

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

# Things We Want to Cover in The Future
* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# Description
LinksIn is a social networking app that builds upon the mechanics of networking on Tinder to create an accessible, sociable media outlet for the gaming community. As gamers, users can connect to LinksIn through their existing gaming accounts, swipe through other gamers and players using the Tinder card-swiping mechanism, and connect with new players that might be in the same game as them. Additionally, with LinksIn, players can also create LAN events and invite people within their 'card community' to join and coordinate gaming events together.

# Deployment
1. SSH into AWS server
```Bash
ssh -i ~/.ssh/linksin.pem linksin@ec2-52-35-41-146.us-west-2.compute.amazonaws.com
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
eb create -db.engine postgres -db.i db.t3.micro -db.user u -db.pass password --envvars SECRET_KEY_BASE=linksin
```
6. Go to [AWS console](https://273020147241.signin.aws.amazon.com/console) to check deployment status

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

## Model
<table>
 <tr>
  <td>
   <table>
    <tr>
     <td colspan="2">User</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>name</td>
     <td>string</td>
    </tr>
    <tr>
     <td>email</td>
     <td>string</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>password_digest</td>
     <td>string</td>
    </tr>
   </table>
  </td>
  <td>
   <table>
    <tr>
     <td colspan="2">Conversation</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>send_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>recv_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>mutual</td>
     <td>boolean</td>
    </tr>
   </table>
  </td>
  <td>
   <table>
    <tr>
     <td colspan="2">Conversation</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>send_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>recv_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>mutual</td>
     <td>boolean</td>
    </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td>
   <table>
    <tr>
     <td colspan="2">Message</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>body</td>
     <td>string</td>
    </tr>
    <tr>
     <td>conversation_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>user_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>read</td>
     <td>boolean</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
   </table>
  </td>
  <td>
   <table>
    <tr>
     <td colspan="2">Profile</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>user_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>description</td>
     <td>string</td>
    </tr>
    <tr>
     <td>user_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
   </table>
  </td>
  <td>
   <table>
    <tr>
     <td colspan="2">Event</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>description</td>
     <td>string</td>
    </tr>
    <tr>
     <td>title</td>
     <td>string</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td>
   <table>
    <tr>
     <td colspan="2">Member</td>
    </tr>
    <tr>
     <td>id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>user_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>event_id</td>
     <td>integer</td>
    </tr>
    <tr>
     <td>created_at</td>
     <td>datetime</td>
    </tr>
    <tr>
     <td>updated_at</td>
     <td>datetime</td>
    </tr>
   </table>
  </td>
  <td></td>
  <td></td>
 </tr>
</table>
  
# Other
* [README Editing Guide](https://guides.github.com/features/mastering-markdown/)

* [Github Link](https://github.com/scalableinternetservices/linksin)
