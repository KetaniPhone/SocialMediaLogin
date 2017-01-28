
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
            pod 'TwitterKit'
        end

9. pod install || pod update







STEP 2
*****************  *******************
Create Twitter application (https://apps.twitter.com/app/new)



STEP 3
*****************  *******************
Add ion info.plist


<key>Fabric</key>
<dict>
<key>APIKey</key>
<string>Jri0W0f9jjPVfYwEnwDUnHDEK</string>
<key>Kits</key>
<array>
<dict>
<key>KitInfo</key>
<dict/>
<key>KitName</key>
<string>Crashlytics</string>
</dict>
<dict>
<key>KitInfo</key>
<dict>
<key>consumerKey</key>
<string>{app-Consumer-key}</string>
<key>consumerSecret</key>
<string>{app-Consumer-Secret-key}</string>
</dict>
<key>KitName</key>
<string>Twitter</string>
</dict>
</array>
</dict>




Note: API Key = consumerKey



STEP 4
*****************  *******************
Add URL Type
Select Project >> Target >> Info >> URL Type >> Click on + sign and add (twitterkit-consumerKey from plist)



STEP 5
*****************  *******************
Copy TwitterClass in your project


STEP 6
*****************  *******************
Call loginWithTwitter(TwitterClass) method from your controller


