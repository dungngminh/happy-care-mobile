# Happy Care

Online Health Consultation Application built with Flutter for Client, ExpressJs for Backend Server (private repo sorry 😣).

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/6ade1e4b31d343f7863ddf652c17d7be)](https://www.codacy.com/gh/komkat-studio/happy-care-mobile/dashboard?utm_source=github.com&utm_medium=referral&utm_content=komkat-studio/happy-care-mobile&utm_campaign=Badge_Grade)
[![Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue.svg)](https://flutter.dev/)

## Features

- Finding doctors, specializations by symptoms. <b>(Currently, the feature is based on database, will upgrade with machine learning later)</b>
- Getting online doctors, busy doctors.
- Asking member user about feeling today for finding doctor (30 mins loop).
- Chatting, sending image 1v1 between doctors and members.
- Doctors can create a new prescription for members.
- Finding doctors by specialization.
- User information CRUD.

## Technology used

- Flutter GetX pattern, [GetX](https://pub.dev/packages/get) for state management. (actually I want to use BLOC (Rx) but I only have 1 month to complete so I use Getx to do it faster. But GetX's build-in DI is so stupid)
- Authentication and Authorization using JWT.
- Backend using ExpressJs, MongoDB.
- Realtime event using Socket.io.
- Cloudinary for storing images.

## Directory structure

```
project
│   README.md
│
│
└───lib
│   |
│   └───core
│   |   |
│   │   └───helpers <--[Helpers function like customShowDialog(context)]
│   |   |
│   │   └───themes  <--[Colors]
│   |   |
│   │   └───utils   <--[logger, validator, cache manager, sharedPref,..]
│   │
│   └───data
│   |   |
│   │   └───api  <-[Provider data from remote]
│   |   |
│   │   └───models
│   |   |
│   │   └───repositories
│   |   |
│   │   └───services
│   |           |
│   │           └───socket_io_service.dart  <--[Socket.io service]
│   │           |
│   │           └───cloudinary_service.dart <--[Cloudinary service]
│   │
│   └───modules <-[Screens, Controllers, Binding,... support modules]
│   |
│   └───routes  <-[Define routes and pages for named navigator, binding]
│   |
│   └───widgets <-[Common widgets for reusing]
│   |
│   └───main.dart
│
│
└───assets
        └───icons
        |
        └───images
        |
        └───logos
        |
        └───lottie <-[lottie animation]
        |
        └───.env <-[.env for environment]
```

## Setup and run

<details>
    <summary>Click to expand</summary>
    <br>

- Download APK
  - [APK - arm64](https://drive.google.com/file/d/1NBD3iTm6hxryz5kGPIbyQLOaGl7lI4kH/view)
- Setup and run
  - Flutter
    - Install [Flutter](https://flutter.dev/docs/get-started/install).
    - Using **`stable`** channel:
      ```bash
      ❯ flutter channel stable
      ❯ flutter upgrade
      ```
    - Flutter doctor:
      ```bash
      ❯ flutter doctor
      ```
    - Install all the packages by:
      ```bash
      ❯ flutter pub get
      ```
    - Create .env file `assets/.env` has following structure:
      ```bash
      BASE_URL=https://komkat-happy-care.herokuapp.com
      ```
    - Run app on real devices or emulator by:
      ```bash
      ❯ flutter run
      ```
      or debug mode in VSCode or some IDEs

</details>

## Screenshots (Running Stable in Mi 9)

Sorry for some UIs are not designed in advance, it will be not responsive for 16:9, not as beautiful as the intro, sign in, sign up because there is no time, just code in mind 😣

### Splash, Intro, SignIn, SignUp

<details>
    <summary>View Screenshots</summary>
    <br>

|                                                               |                             |                             |
| :-----------------------------------------------------------: | :-------------------------: | :-------------------------: |
|                         Splash Screen                         |           Intro1            |           Intro2            |
| <img src="screenshots/splash.gif" width="420" height="560" /> | ![](screenshots/intro1.png) | ![](screenshots/intro2.png) |
|                            Intro3                             |           Intro4            |                             |
|                  ![](screenshots/intro3.png)                  | ![](screenshots/intro4.png) |            ![]()            |
|                            Sign In                            |           Sign Up           |                             |
|                  ![](screenshots/signin.png)                  | ![](screenshots/signup.png) |            ![]()            |

</details>

### Main Screen (Member Role)

<details>
    <summary>View Screenshots</summary>
    <br>

|                                                         |                                        |                                               |
| :-----------------------------------------------------: | :------------------------------------: | :-------------------------------------------: |
|                       Home Screen                       |        Choose if you feel good         |   Choose if you feel bad to finding doctor    |
|             ![](screenshots/home_user.png)              |  ![](screenshots/if_choose_good.png)   |    ![](screenshots/if_choose_not_good.png)    |
|                      More Symptoms                      |      Result for choosing symptoms      |                 Choose Doctor                 |
|            ![](screenshots/more_symptom.png)            |      ![](screenshots/result.png)       | ![](screenshots/choose_doctor_by_symptom.png) |
|                         Search                          |              Chat Screen               |                   Chat Room                   |
|               ![](screenshots/search.png)               | ![](screenshots/chat_user_history.png) |        ![](screenshots/chat_room.png)         |
|              Chat With Typing Event Socket              |      Image Preview Before Sending      |               All Prescriptions               |
| ![](screenshots/chat_with_typing_event_socket_user.png) |    ![](screenshots/image_user.png)     |   ![](screenshots/prescription_member.png)    |
|                   Detail Prescription                   |     Detail Information Member role     |               Edit Information                |
|        ![](screenshots/detail_prescription.png)         |    ![](screenshots/detail_user.png)    |     ![](screenshots/edit_user_detial.png)     |
|                Detail Information Doctor                |         Change password dialog         |             Dialog choose avatar              |
|           ![](screenshots/detail_doctor.png)            |    ![](screenshots/change_pass.png)    | ![](screenshots/dialog_image_choose_edit.png) |
|                        More news                        |                WebView                 |                                               |
|             ![](screenshots/more_news.png)              |      ![](screenshots/webview.png)      |                     ![]()                     |

</details>

### Main Screen (Doctor Role)

<details>
    <summary>View Screenshots</summary>
    <br>

|                                                    |                                          |                                                   |
| :------------------------------------------------: | :--------------------------------------: | :-----------------------------------------------: |
|                    Home Screen                     |               Chat Screen                |                     Chat Room                     |
|          ![](screenshots/home_doctor.png)          | ![](screenshots/chat_doctor_history.png) |       ![](screenshots/chat_room_doctor.png)       |
|           Chat With Typing Event Socket            |            Create Precription            |           Image Preview Before Sending            |
| ![](screenshots/chat_with_typing_event_socket.png) | ![](screenshots/create_precription.png)  | ![](screenshots/send_mess_with_image_preview.png) |
|                 All Prescriptions                  |           Detail Prescription            |                Edit a Prescription                |
|         ![](screenshots/prescription.png)          |       ![](screenshots/detail.png)        |         ![](screenshots/edit_detail.png)          |
|           Detail Information Doctor role           |             Edit Information             |               Dialog choose avatar                |
|          ![](screenshots/user_doctor.png)          |      ![](screenshots/edit_user.png)      |   ![](screenshots/dialog_image_choose_edit.png)   |
|                     More news                      |                 WebView                  |                                                   |
|           ![](screenshots/more_news.png)           |       ![](screenshots/webview.png)       |                       ![]()                       |

</details>

### Some gif(s)

<details>
    <summary>View gif(s)</summary>
    <br>

|                                                                                  |
| :------------------------------------------------------------------------------: |
|                            Finding Doctor By Symptoms                            |
| <img src="screenshots/finding_doctor_by_symptom.gif" width="200" height="450" /> |

</details>

## Todo

- WebRTC for voice, video call
- Notifications
- Rebuild UI (i think no no no because i am very lazy 😣)

## Contributors ✨

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><img src="https://avatars.githubusercontent.com/u/63831488?v=4" width="100px;" alt=""/><br /><sub><b>Nguyễn Minh Dũng</b></sub></a><br /><a href="https://github.com/komkat-studio/happy-care-mobile/commits?author=dungngminh" title="Code">💻</a> <a href="https://github.com/komkat-studio/happy-care-mobile/commits?author=dungngminh" title="Documentation">📖</a>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
