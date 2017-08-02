# Real Time Chat Application

## Goal:
    - Build a real time chat application for 2+ people
    - Implement authentication and/or other "features"

## Requirements:
    - Firebase RT DB
    - Firebase Hosting
    - Use RiotJS or Vanilla Javascript, CSS and HTML
    - NO EXTERNAL LIBRARIES other than RiotJS
    - Judged on UI/UX Feel, program structure

## Vision
    - User logs in and it shows list of chat rooms with number of ppl in each room
    - Nav bar across top shows signed in user, logout
    - There is a button to add a new Room
        - Rooms must be uniquely named
    - Once a room is added, user can select any room to join it
    - Room has Back button in upper left to go back to Room Selection list
    - Expandable bar on right shows users currently in the room
    - When joining room, shows most recent XX number of messages
        - Scrolling up will condiitonally load more until no more exist
    - Input bar at the bottom to type your messages
        - Shift+Enter to enter new lines
        - Enter to send message
    - All pages lead to login if not auth'd user

## DB Related:
    - Firebase RT DB is a NoSQL DB - document store, non relational

    - What objects are represented here
        - Chat Rooms
            - Name
            - Id
            - Description
        - Messages
            - User - Who said it
            - Room - In what room was it said
            - TimeStamp - What time (UTC) was it said
            - Message - What was the message
        - Users
            - May be managed by Firebase Auth system?

## Page Structure:
    - Login Page
        - Has link to Create new user
    - Room Selection Page
        - Select Room to join
    - Chat Room
        - Where messages are exchanged
        - Back button to the Room Selection page
    - All pages should redirect to login if user not auth'd

## Process:
### Research
    - Setup Firebase Project - Done
    - Overview of Hosting
    - Overview of Database
    - Overview of Auth System - Done
    - Overview of RiotJS

### Design
    - Design DB Structure
    - Design App Structure
    - Design Page Flow
    - Site Styles

### Implementation
    - Serve site locally
    - Implement something using RiotJS
    - Communicate with the database
        - Read from database
        - Write to database
    - Test Auth system - get user information and display it
    - Send a message to chat room and have it pushed to other users

