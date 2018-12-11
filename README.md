Feature List - 

1. Semi Viper Architecture consist of - View Controller, Interactor, Router and Models with Services added using Dependency Injections.
2. Validation class for basic validations like: - email, password etc.
3. Network service class using alamaforie as the base.
4. Notification service class to display alert anywhere in the app and handle notification related actions that includes local notification, push notification or launching apps via notification tap
5. Reachablity pod to check for internet connection.
6. UIViewcontroller extension for - HUD and Alert.
7. R.swift pod for naming and instantiation shortcuts for objects like :- storyboard, image, color etc.
8. Swiftlint for maintaining coding standards.
9. Storage service class which would handle storage types like :- local(UserDefaults), DB or cloud.
10. textfield extension which handle placeholder color and max length.
11. Native back button image is replace with custom image, so that we don't want to keep an barbutton item. Title of back bar item is removed by adding spaces in storyboard in back button value of navigation controller.
12. Custom template for creating new viewcontroller, interactor, router and storyboard all at once, with boiler plate code. Template can be found in the first level folder along with the instruction of how to setup.
13. Login, Register and Forgot Password VC added and navigation is set with textfield validations.
14. Remote notification or push notification are configured and device token is returned using delegate in notification service.
15. StringExtensions added
16. Haptic Feedback class added with all types of feedback
17. Location service added with features like :- Get location once, Get continous location update with support of background mode and if permission is denied then show alert with redirection to device settings.  Also, reverse geodcoding is used to fetch the address for the respective location.

Pending Items - 

1. Localisation
2. Keychain storage for password
3. Improvement in gallery service
4. Static listing with pull to refresh
5. Page controller


Rules for naming - 

1.  UIElements -> (name of label) 

2. Func -> Description(withLoginParameter parameter: parameter)

3.     
MARK: - Outlets
MARK: - Variables
MARK: - Action methods
MARK: - Life cycle methods
MARK: - UI setup methods. ( Func setupUI() )
MARK: - Helper methods
MARK: - Extensions
MARK: - API methods
MARK: - Navigation Methods

4. Declare all the constants at the top of the class(inside) . 

5. Enums above class

6. Imports at the top of the file

7. Use access specifiers like: - (private, file private, private(set)) for both functions and variables.

8. All extensions related to each other should be in separate file like :- UIView: Extension etc.

9. Comments above important variables, regarding its use.
