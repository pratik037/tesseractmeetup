# Tesseract Meetup
A simple login and registration based app that implements Provider as state management and uses Firebase auth for login and registration.

Please follow the below setup carefully to successfully run the project in your local system.

## Pre-requisites
1. Flutter *beta* channel - Switch using `flutter channel beta` command. And the execute `flutter upgrade` command to upgrade your local flutter installtion.
	Note - You can switch back to stable any time using `flutter channel stable` & `flutter upgrade` command.

# Setting up the project
There are two different branches in the project, Master branch and the altdesign branch.
- Master branch just has the barebones without any customised look.
- Altdesign branch has modified app customisation.
Please choose and switch accordingly
## Steps:
1. Clone the github repository into your local system using `git clone` command or download the zip of the project.
2. Create a firebase project by visiting [Firebase Console](www.console.firebase.google.com). If you are **new** to Firebase, please go to the section [Firebase Setup](#firebase-setup) for a detailed setup of the firebase project.
3. After creating the project, click on the *Android Icon* on the homepage of the project.
4. Fill all the relevant details needed for the android app along with generation of the SHA-1 Key, since it is required for authentication to work. Please make sure all the details are correct, otherwise the firebase authentication functionality won't work.
5. After filling up the details, download the *google-services.json* file and place it in *[project directory]/android/app* folder.
6. Add the required configuration in `build.gradle` file and **app-level** `build.gradle` file from [here](https://pub.dev/packages/firebase_auth). If this is not done properly, the project will throw errors. 
7. Once the changes are made, we are good to go. You can successfully execute the project from *lib/main.dart* file or any other dart file for that matter.

## Switching between the branches
To switch between Master and Altdesign branch, type `git checkout [branch name]` and this will pull the code according to the branch name that is entered.
- To pull Master branch, the branch name should be *master*. So the command will be
`git checkout master`.
- To pull Altdesign branch, the branch name should be *altdesign*. So the command will be `git checkout altdesign`.
**Note**: If you are facing any issues, run `git branch -a` to verify the name of the branches.

## Firebase Setup
This section is for people who are getting started firebase and have no prior knowledge of firebase.
- Steps:
	- Go to [Firebase Console](www.console.firebase.google.com) and click on Add Project/ Create Project.
	- Give a name of your choice to the project and continue. Turn off Google Analytics on the next page, since it is not needed for our project. Click on ***Create*** button to create the project.
	- Once the dashboard/ homepage for the project loads, click on the **Android** Icon that is visible on the dashboard. 
		- Now we need to register the app here. Enter the Android Package name from the applicationID in **app-level** *build.gradle* file of the project that is cloned in your local system.
		- Then we need to generate a SHA-1 key for the project. To do this, open a terminal in the project folder and then enter the following commands:
			- For windows: 
			`keytool -list -v \
-alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore`
			-	For Linux/Mac:
			`keytool -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore`
		-	If prompted for a password, the default password is `android`. Copy the SHA-1 generated and paste it in the SHA-1 key dialog box on the Register App page of Firebase.
		-	Download the *google-services.json* file generated and move it to android/app folder of the project.
		-	Now follow the instructions here to add the required configuration carefully, otherwise errors will be encountered.
			##	Android Integration:
			Enable the Google services by configuring the Gradle scripts as such.
			1. Add the classpath to the `[project]/android/build.gradle` file.
			
		```
				dependencies {
				  // Example existing classpath
				  classpath 'com.android.tools.build:gradle:3.2.1'
				  // Add the google services classpath
				  classpath 'com.google.gms:google-services:4.3.0'
				} 
		```
		2. Add the apply plugin to the `[project]/android/app/build.gradle` file.
		```
				// ADD THIS AT THE BOTTOM
				apply plugin: 'com.google.gms.google-services'
		```
		Note: If this section is not completed you will get an error like this:
		```
				java.lang.IllegalStateException:
				Default FirebaseApp is not initialized in this process [package name].
				Make sure to call FirebaseApp.initializeApp(Context) first.
		```
		