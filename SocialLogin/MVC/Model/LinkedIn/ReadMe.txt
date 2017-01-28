
STEP 1
***************** Add LinkedIn Framework *******************
add 'linkedin-sdk' framework in your project



STEP 2
*****************  *******************
Create Twitter application (https://www.linkedin.com/developer/apps)



STEP 3
*****************  *******************
Add ion info.plist


<key>LIAppId</key>
<key>CFBundleURLSchemes</key>
<array>
<string>li{LIAppId}</string>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
<string>linkedin</string>
<string>linkedin-sdk2</string>
<string>linkedin-sdk</string>
</array>
<key>NSExceptionDomains</key>
<dict>
<key>linkedin.com</key>
<dict>
<key>NSExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
</dict>
<key>NSAllowsArbitraryLoads</key>
<true/>




STEP 4
*****************  *******************
and copy (func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {) Method in AppDelegate



STEP 5
*****************  *******************
Copy LinekdInClass in your project



STEP 6
*****************  *******************
Call loginWithLinkedIn(LinkedInClass) method from your controller




