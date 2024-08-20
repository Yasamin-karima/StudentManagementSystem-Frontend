# Student Management System (android application)

**An almost comprehensive android application solution for managing schools and educational centers IN PERSIAN**

This Student Management System is The frontend part of the project, written in Dart and Flutter framework.<br/>
This application is in PERSIAN language and empowers students to:
1. manage courses
2. check submit assignments
3. check grades
4. set todos
5. check news

**Please note:** This is only the frontend component of the project. There's a separate repository containing backend and server-side files which u need to download and setup to use the features of this android app.

## Application 
![Recording2024-08-20164825online-video-cutter com-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/89c5ba27-bbd9-41bb-aa5e-02b3de305f3c)

## How to install and use
- If you are an android developer, just clone the project and run `main.dart`.
- Otherwise, please search for "ways to run an android project". (apk file is in build/app/outputs)
- actually usage is straightforward due to the guidance of the app.

## For Developers
This project is open-source and welcomes contributions. Here's some information about the codebase:
- `models.dart` in `classes` directory contains all the objects definitions used in the app.
- Directories `fonts` and `images` contain assests.
- `NavigationBar.dart`, `Forms.dart` and `buttons.dart` are some classes which their functionality is obvious.
- This project uses **socket** to make a connection between server and application. `SocketMethods.dart` is a file containing all methods to communicate with server (as static methods).
- `main.dart` is the start point of the application.
- At last, `Pages` directory. As the name suggests, it includes every page's code in separate files.

## Known issues:
1. There isn't android interface for teachers.
2. Pages doesn't reload after making changes unless u do it yourself.
3. ‌Birth date is decorative :) <br/>
P.S: Actually I don't have time to work on these issues

## License
This project is licensed under the MIT License.
