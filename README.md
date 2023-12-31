# benevoclic mobile interface

This Application is a smartphone application maked in Dart language with Flutter Framework.
It works with REST API in the other repository.

This application works with API locally or with the remote API.
The application works with the remoteAPI by default but you can change url in lib/util/globals.dart.
When you use the local API, and you change url with your computer IP address.
 

This application allow you to create an account and login in with it. As Association or Volunteer.
Association side:
  - Publish announcements
  - See own announcements
  - accept Volunteer
Volunteer side:
  - Participate to announcements
  - See announcements he particpate
  - See Assoication profiles

# Installation

Need to have following configurations:
- Dart  3.2 >
- Flutter
- Firebase

# Exectue project

Execute the following command to start project : 
- dart run build_runner build --delete-conflicting-outputs  (Make Models package for API)

Then 
- Flutter run  (execute the project)

# Ressources
## anonymous authentification with firebase

Vidéo qui montre comment se passe l'authentification avec firebase
  https://www.youtube.com/watch?v=gV8qlGkaZVE&t=662s


## Gmail authentification :

Commande pour entrer code encryptage nécessaire pour utiliser l'authentification gmail 
  https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google
Video montrant pas à pas l'authentification gmail:  
  https://www.youtube.com/watch?v=VCrXSFqdsoA
