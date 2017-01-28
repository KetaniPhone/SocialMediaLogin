
STEP 1
***************** SETUP PODS *******************

1. Create New Project
2. Open project in External editor. (By right click on Project)
3. cd ..
4. sudo gem install cocoapods
5. pod setup
6. touch podfile
7. open -e podfile

8. Copy Bellow setting in file then Save and close podfile

        source 'https://github.com/CocoaPods/Specs.git'
        platform :ios, ‘9.0’
        use_frameworks!

        target ‘YOUR_APPLICATION_NAME’ do
            pod 'Google/SignIn'
        end

9. pod install || pod update







STEP 2
*****************  *******************
Create Google application (https://developers.google.com)



STEP 3
*****************  *******************
Download Plist file (https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cnturl=https:%2F%2Fdevelopers.google.com%2Fidentity%2Fsign-in%2Fios%2Fsign-in%3Fconfigured%3Dtrue&cntlbl=Continue%20Adding%20Sign-In)
And add it in your project



STEP 4
*****************  *******************
Add URL Type
Select Project >> Target >> Info >> URL Type >> Click on + sign and add (REVERSED_CLIENT_ID from plist)



STEP 5
*****************  *******************
Copy GmailClass in your project
and copy (func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {) Method in AppDelegate


STEP 6
*****************  *******************
Call loginWithGmail(GmailClass) method from your controller


