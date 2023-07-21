# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Running the tests](#running-the-tests)
7. [Deployment](#deployment)
8. [Dependencies](#dependencies)
9. [Design](#design)
10. [API](#api)

# Overreacted
This is a sample project using Swift and Combine

# Description

Overreacted is a minimalistic iOS project written in Swift (Using Combine) that retrieves sample posts and displays them on a Home screen along with a detailed view. <br />
The project aims to keep things simple by avoiding the use of third-party libraries, although if you're going to use this project as your code base, <br />
it is recommended to use popular libraries like [AlamoFire](https://github.com/Alamofire/Alamofire) for network layer and [Kingfisher](https://github.com/onevcat/Kingfisher) for remote image loading. 
The current implementation may suffice, but using these libraries can enhance the functionality of the application. 

# Getting started
<p>
1. Make sure you have the Xcode version 12.0 (Swift 5) or above installed on your computer.(this project used Xcode 14 for writing the project)<br>
2. Download the Overreacted project files from the repository.<br>
3. There's no dependencies for this project! (then Voilà!)
4. Open the project files in Xcode.<br>
5. Review the code and make sure you understand what it does.<br>
6. Select your desired Simulator (top left corner)
7. Hit the run button.
You should see the applicaiton up and running through the simulator. have fun<br>

# Usage
no credential is required, you can use two targets (Debug or normal)
in the environment's arguments you can define BASE_URL (which is currently defined as `https://jsonplaceholder.typicode.com/posts`)

# Architecture
This project is using MVVM strcutral design pattern + Dependecy Injection for more testablity
in order make the view model independent from it's dependencies and make it testable, we used protocols to pass dependencies, 
then it would be possible to test them seperately with mock dependencies

# Structure 
* "Screen": Files (view controllers and view model and xib files) of a single screen
can be place in it's own hierarchy 
* "Utils": The reusable codes (generic functionalities) which are not dependent to the proejct's logic like netwrok layer, 
making a persited data, .. would be placed in the Utils file.
* "Model": All of the dump models would be placed here, in order to be accessible for whole project. 
* "Requests": You can observe all of the requests here, in order to update or edit them more easily.

# Running the tests
Currently the tests are not available, but the tests are coming in the next step.

# Deployment
Keep in mind that deploying an iOS app to the App Store requires having an 
Apple Developer account.

1. in the Xcode please first select the Overreacted target (not Debug)
2. in the target section of the project properties, select Signing& Capbilities. 
and add your developer account in order to resolve the provisioning profiles (for build the application)
3. Now you can go to Product menu (from top bar) and select Archive, in the end you should be able to distrobute your iPA in the apple Store.

# Dependencies
No Dependencies! :)

# Design 
All the Designs and element are copied from the Website for [Overreacted](https://overreacted.io/)
as a sample.

# API 
* We are using a REST API
* We are a dummy endpoint which you can open manually from [here](https://jsonplaceholder.typicode.com), the endpoint can be changed in the 
environment arguments of the target as well (as BASE_URL param)
* For HTTP networking we are using a custom network layer using Combine (for more expandability you can use [Alamofire](https://github.com/Alamofire/Alamofire))
