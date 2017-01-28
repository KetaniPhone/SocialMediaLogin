
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

        target ‘SocialLogin’ do
            pod 'FacebookLogin'
        end

9. pod install || pod update







STEP 2
*****************  *******************
Create Facebook application (https://developers.facebook.com)



STEP 3
*****************  *******************
Add ion info.plist

<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLSchemes</key>
<array>
<string>fb{your-app-id}</string>
</array>
</dict>
</array>
<key>FacebookAppID</key>
<string>{your-app-id}</string>
<key>FacebookDisplayName</key>
<string>{your-app-name}</string>
<key>LSApplicationQueriesSchemes</key>
<array>
<string>fbapi</string>
<string>fb-messenger-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
</array>
<key>NSPhotoLibraryUsageDescription</key>
<string>{human-readable reason for photo access}</string>







STEP 4
*****************  *******************
Add URL Type
Select Project >> Target >> Info >> URL Type >> Click on + sign and add (fb{your-app-id})



STEP 5
*****************  *******************
Copy FacebookClass in your project
and copy (func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {) Method in AppDelegate


STEP 6
*****************  *******************
Call loginWithFacebook(FacebookClass) method from your controller


