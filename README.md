# blood_bank

Team Members :
Hari Krishnan Raj Kumar, Lakshmi KS, Nidhi Kumar, Shristi Srivastava

Final submission doc link:

https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/FinalDoc.pdf
Please download the pdf file for better viewing experience.

1) Does it accomplish the stated objective?
   
The main objective of the project is to create a community based blood bank application that
connects donors and hospitals seamlessly. This objective is met through the implementation of
several key functionalities as listed below.
1. Blood Donation Requests: Hospitals could fill out forms specifying the required blood group,
quantity, and description. This information is sent to users, notifying potential donors about the need.
This comes in handy during emergency situations.
2. Event Creation: Hospitals can create events which will then be displayed to donors thus
engaging the community and organizing blood donation drives.
3. Nearby Hospitals: Users can find hospitals within a 5-mile radius using latitude longitude
calculations. It's a simple algorithm that we developed, ensuring that users can locate nearby
hospitals quickly.
4. Google Maps Integration: Users can open Google Maps with a hospital's address, which helps
in easy navigation. This happens through the click of a button.
5. Donor List: Hospitals have access to a list of donors, which is updated automatically as new
donors sign up.
6. Role-based UI and Functions: Different user interfaces and functionalities are provided for
donors and hospitals, thus differentiating based on access controls.
7. Secure Authentication: Passwords are encrypted using Firebase's standard encryption method,
ensuring user security.
These features collectively contribute to achieving the goal of facilitating quick and efficient
communication between donors and hospitals, particularly in emergency situations.
Please note that we were not able to implement email notifications as all the providers are paid, thus
we added a live feed in the app which will have all new blood request notifications. If this product
were to be launched, we could add a paid email service or also push notifications in the app.


2) Does it deliver on the “value proposition”?

The value proposition of the application lies in addressing the decline in blood donations by
enhancing local community engagement and enabling real-time communication between hospitals
and potential donors. The implemented features deliver on this proposition:
1. Real-time Notifications: When a blood donation request is made, notifications are sent to users,
ensuring timely awareness and response. In our current implementation it all be shown in the live
feed in the home page.
2. Local Engagement: By displaying nearby hospitals and creating community events, the app
fosters local involvement and encourages people to participate in blood donation drives.
3. Efficient Communication: Hospitals can reach out to a broad audience quickly through the app,
ensuring that emergency blood needs are communicated effectively.
4. Accessibility: The user-friendly design and the integration with Google Maps make it easy for
users to navigate and respond to requests.
The combination of these functionalities ensures that the app is not only useful for hospitals but also
beneficial for the general public, thus delivering on its value proposition of enhancing blood donation
rates and improving emergency response.

3) Does it respect user privacy/is it secure?
User privacy and security are critical aspects of this application, and the project addresses these
effectively:
1. Password Encryption: Passwords are encrypted using Firebase’s standard encryption methods,
which ensures that user credentials are stored securely.
2. Authentication: The app uses Firebase Authentication for secure login and session
management, protecting user data and preventing unauthorized access.
3. Data Handling: User data, including personal information and location data, is handled securely,
adhering to best practices in data privacy.
4. Role-based Access Control: Different functionalities are provided based on user roles (donor or
hospital), ensuring that sensitive operations are restricted to authorized users.
These measures collectively ensure that the application respects user privacy and maintains high
security standards.

4) Does it have proper app lifecycle/state management?
The app demonstrates proper lifecycle and state management through several key practices:
1. Stateful Widgets: The use of stateful widgets ensures that the UI can respond dynamically to
changes in the application state.
2. Lifecycle Methods: Methods like ‘onCreate()’, ‘onStart()’, ‘onResume()’, and ‘onPause()’ are
used effectively to manage the app's lifecycle, ensuring that the app behaves correctly in response
to different states and user interactions.
3. State Mutation and setState(): The ‘setState()’ method is used to handle state changes and
update the UI. For example, when a user interacts with a text field or makes a donation, ‘setState()’
ensures that the UI reflects the new state.
4. TextEditingController: This handles the state of text input fields, ensuring that the app can
manage user input and validation effectively.
These practices ensure that the app provides a smooth and responsive user experience, handling
state changes and lifecycle events efficiently.


5) Does it address at least three additional challenges (other than privacy and
state management) unique to mobile app development?
The project addresses several additional challenges unique to mobile app development:
1. Scalability and Performance:
- Database Optimization: Efficient database queries and the use of caching mechanisms ensure
that the app performs well, even under high load. We have done these in our database setup in
firebase.
2. Geolocation and Mapping::
- Google Maps Integration: The app uses Google Maps to provide location-based services,
helping users find nearby hospitals and navigate to them easily.
- Lat-Long Calculation: An algorithm calculates the distance between the user and hospitals,
ensuring accurate results within a 5-mile radius.
3. User Adoption and Engagement:
- Notifications: Push notifications and emails keep users engaged and informed about urgent
blood donation needs and upcoming events.In our current implementation it all be shown in the live
feed in the home page.
- User-Friendly Design: The intuitive design and clear navigation enhance the user experience,
encouraging regular use and engagement.
4. Input Validation:
- Regex Validation: Input validations using regex ensure that user inputs are correct and prevent
errors.
- Age Validation: Specific validations for donor eligibility (example: minimum age of 18) ensure
compliance with donation guidelines.
By addressing these challenges, the app ensures reliability, ease of use, and robust performance,
making it a comprehensive solution for the intended purpose.

6) Does it have a good user experience?
The project provides a good user experience through several design and functionality choices:
1. Intuitive Interface: The app’s interface is designed to be user-friendly, with clear navigation and
well-organized information. Users can easily sign up, log in, find nearby hospitals, and respond to
blood donation requests.
2. Role-Based Views: Different views and functionalities for donors and hospitals ensure that users
see only relevant information and options, making the app easier to use.
3. Visual Feedback: Screenshots in our github readme demonstrate that the app provides visual
feedback to users, such as showing formatted time and date for events, lists of donors, and details
of events.
4. Accessibility: The integration with Google Maps and clear navigation options enhance the
accessibility of the app, making it easy for users to find and reach hospitals.
Based on the above features and with feedback from our testers as listed in checkpoint 4, we
believe our applications provide a good user experience.

Final sprint features:

Adding live feed for blood requests coming from blood banks - displayed in donor's homepage:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/28.png" width="300">

Adding age validations in sign up:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/29.png" width="300">


Please check  BasicFunctionality.pdf for documentation questions, all screenshots are found below only.
https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/BasicFunctionality.pdf


Basic functionality implemented:

•	We have added the Blood donation functionality, This allows the hospital user to fill a form with required blood group, quantity required and description, which will be sent to the users.

•	We have added the Event creation functionality, where the hospital user can create an event by entering the event details which will be displayed for the users.

•	We have added the nearby hospitals functionality which helps the users filter nearby hospitals, this is done using the lat long calculation where we have developed an algorithm to find the closest ones to a particular latitude - longitude.

•	It takes into account the 5-mile radius.

•	We have added functionality to open google maps with a hospital's address which can be triggered by a button click by the user.

•	Added functionality to list all donors.

•	Added functionality to have different UI and functions based on User role - Donor/hospitals. The password is encrypted using the firebase standard encryption method.

Proper state management:

Please find an example explanation based on financial donations page, The same logic is implemented in all functions:

onCreate(): When the DonationsPage is created, the constructor is called to initialize the widget. Here, the DonationSource parameter is set to identify the source of the donation.

onStart(): The widget is being displayed, the build() method is called to create the UI elements.

onResume():
In Android, onResume() is called when the activity is ready for the user interaction. In our case, when the widget is rendered, the user can interact with it, such as entering the donation amount.

State Mutation (User Interaction):
When the user interacts with the widget, such as entering an amount in the text field, it triggers a state change. This is when the user interacts with UI elements in an Android app, triggering state changes in the activity or fragment.

setState() (UI Update): When the state changes, for example, when the user enters an invalid amount, setState() is called to update the UI to reflect the new state.

Async Operations (donate()):

Performing asynchronous operations, such as making a network request, is similar to performing background tasks in Android, typically done in onPostExecute() of an AsyncTask or in a background thread. In our case, when the user initiates a dona The state management approach used in the DonationsPage widget is primarily handled through the setState method. This method is called whenever there's a change in the state of the widget, causing the UI to rebuild with the updated state.

The TextEditingController hadnles the onPause state.

Stateful Widget: DonationsPage is a stateful widget, indicated by its StatefulWidget superclass.

State Object: The stateful widget has a corresponding state object named _DonationsPageState, where the stateful logic resides.

State Variables:

amountController: A TextEditingController to control the input in the amount text field.

isValidAmount: A boolean variable to track whether the entered amount is valid or not.

State Mutation:

The setState method is called when the amount text field's value changes. Inside the onChanged callback of the text field, setState is invoked to update the isValidAmount variable based on the validity of the entered amount.

Remaining work to be completed for the next phase of the project:

Email notifcations to the users when blood donation request is published.
Input validations using regex
Age validations for donors (min 18yo)
Validations for blood donations page.



Screenshots of the updates ->

The below image shows slider drawer for Hospitals. It differentiates from Donor's view of sloder drawer.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/22.png" width="300">

The below image shows the formatted Time and Date for events added by the hospital.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/21.png" width="300">

The below image shows all the donor list. Previously, all the donors were not visible. With the recent update, when a donor signs up, it will automatically be shown in the hospital's donor list.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/23.png" width="300">

The below image shows Stats & Facts

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/24.png" width="300">

The below image shows when a hospital registers, its longitude and latitude gets stored in the firebase.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/25.png" width="300">

The below image shows the events added by the hospital

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/27.png" width="300">

The below image shows the details of the even. You go to this page by clicking on the event.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/26.png" width="300">

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Please check Checkpoint 2 - Simple Prototype.pdf for List of features needed for the MVP + Breakdown of tasks & Mapping between features and value(s) to be delivered by your app (justification)

The below screenshots show our UI / UX with data pulled from firebase, Navigation and event based actions:
The below image is the signup screen for donors:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/12.png" width="300">

The below is the signup screen for hospitals:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/13.png" width="300">

The below is the log in screen for hospitals:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/18.png" width="300">

The below is the log in screen for donors:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/17.png" width="300">


If the login is invalid : invalid login event, it shows the below:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/10.png" width="300">

The below are the options provided in slider:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/14.png" width="300">

The below is the nearby hospitals screen for donors:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/2.png" width="300">

The below shows what the user can see after clicking the map icon:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/15.png" width="300">

The below shows the Edit profile page for donor:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/16.png" width="300">

The below screen is used by hospitals to create a new event:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/3.png" width="300">

The below screen is used by hospitals to request for blood:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/19.png" width="300">

The below screen is used by hospitals to filter by blood group:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/20.png" width="300">

The below screen is used by donors to see nearby events:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/4.png" width="300">

The below is the financial donation screen:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/7.png" width="300">

Once the button in the above is done and if its succesfull based on the event trigger for donate it shows the below:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/8.png" width="300">

The below image shows all previous donations:

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/9.png" width="300">

The below image is the homepage for all hospitals, it shows all donors, the user can filter based on blood group. It is an event based action.

<img src="https://github.com/nidhikumar/blood-bank/blob/branch-nidhi/screenshots/11.png" width="300">

Readme file of previous checkpoint, the above are the updates:



Summary of Project:

4.5 million Americans would die each year without life saving blood transfusions. Approximately 32,000 pints of blood are used each day in the United States. Every three seconds someone needs blood, with the casualties spiking up due to lack of blood pints, it's high time a tech enabled community based product helps to solve this alarming issue. A community based blood bank application involving all people and Hospitals in a community to tackle emergency situations
Project Analysis

Value Proposition:

Number of U.S. blood donors hits all-time low for past 20 years - Red Cross.
The value proposition lies in addressing the decline in blood donations by facilitating quick and efficient communication between donors and hospitals. This not only benefits the general public by saving lives but also enhances hospitals ability to serve their patients effectively.
Primary Purpose:

The primary focus is to benefit the public, hospitals registered with the Blood bank can raise push notifications when blood donors are required, this will notify all donors in the nearby area. These emergency situations can be handled.
●	First it helps the common people, saving lives when at crucial situations.
●	Secondly Hospitals are also benefited as it helps them to serve better.
Target Audience:
Primary Target Audience - General Public: People from all age groups and across the board with a commitment of being blood donors daily or during emergencies.This includes:

●	Residents who know the importance of having volunteer blood donors and are trusted with the precious life of another person.
●	People that actively view themselves as health-conscious who like to help, and who want to leave a better world than the one they started with.
●	Students, professionals and retirees at youth and middle age who are characterized with the necessary level of high readiness to increase their regular blood donating rate.

Secondary Target Audience:

Hospitals and Healthcare Facilities:
Public Hospitals: Medical facilities that provide health services to every member of the community government regardless of his financial position. They can thus at ease access a pool of merely possible blood donors in an emergency through the portal.
Private Hospitals: Along with not only the healthcare system which serves patients of diverse levels of insurance. They can enjoy the app's valuable features like the subscription to the premium services such as index priority access to blood donors and an advanced notification system with ease and comfort.
Tertiary Target Audience:

Community Organizations and NGOs:
Blood Donation Drives: They can use the app for  purposes to launch their campaigns, seek donations, and organize pick up appointments for the kind-hearted contributors.
Success Criteria
1. User Adoption and Engagement:
- Registration Rate: Through achieving the registration ratio of 80% among the population eligible for the blood donation, the general contribution to the blood system would be high enough.
- Active User Engagement: The effort to increase the user retention rate of the application shows the users active engagement with the application in not less than 60% of the total registered user monthly.
2. Blood Donation Impact:
- Donation Volume: The application is envisioned as a tool for seeing that 40% of the blood donations facilitated through the application, compared to the baseline, meet the blood supply demands as desired.
- Emergency Response Time: The application’s utility is evident in prompting responses to emergency blood donation requests with a response time of less than 30 minutes.
3. Hospital Adoption and Satisfaction:
- Hospital Registration Rate: Ensuring at least 70% of the hospitals who are eligible bind partnerships allows wide outreach, encouragement and usage of the app for their blood donation management and coordination.
- Satisfaction Surveys: Collect feedback and suggestions and evaluate satisfaction
4. Community Impact and Recognition:
- Lives Saved: Recording and safeguarding the quantitative and qualitative data of the life-saving effect of having the blood donations on schedule due to the application will give undeniable evidence of the lives saved or positively impacted.
- Community Recognition: Achieving positive media coverage, testimonials and procurement of recognition awards from healthcare institutions and community leaders is sufficient proof of the application's significance in solving the blood donation problems and saving lives.

Competitor Analysis
Our project aims to establish a community-based blood bank application that leverages technology to connect donors and hospitals efficiently. We face competition from established organizations and newer tech-based solutions.
Direct Competitors
Red Cross Blood Donor App:
Strengths: Extensive network, robust infrastructure, nationwide recognition, and trust built over many years. Efficient in organizing large-scale blood drives and managing vast donor databases.
Weaknesses: May not offer the same level of real-time, localized interaction or community-based features as newer, more agile tech solutions.
Indirect Competitors
Local Blood Banks and Hospitals: Often manage donations internally without extensive technological support.
Strengths: Strong relationships with local communities and direct control over their blood supply and logistics.
Weaknesses: Lack of a dedicated platform for engaging donors, which can result in inefficiencies and missed opportunities for rapid response in emergencies.
Competitive Advantage
Community Focus: Our app specifically enhances local community engagement by enabling hospitals to send push notifications to nearby donors in real-time during emergencies, which is a key differentiator from larger, less localized competitors.
Enhanced Accessibility: By focusing on a user-friendly interface and facilitating direct communication between hospitals and donors, we aim to make the donation process more accessible and efficient.
Strategic Opportunities
Expanding Digital Outreach: There is an opportunity to engage a younger demographic by enhancing the digital experience, including mobile app notifications and a streamlined donation process.
Partnerships for Growth: Collaborating with local hospitals and health organizations to ensure the app is integrated into their existing systems could expand our reach and effectiveness.
By focusing on a technology-driven, community-oriented approach, our app seeks to fill a niche that current competitors have not fully addressed. This focus on local engagement and real-time connectivity positions us to become a vital tool in improving blood donation rates and emergency responsiveness.


Monetization Model:

Subscriptions: It's free for all public hospitals, but the private hospitals need to pay an annual fee.
Financial Donations: Have financial donation options in the app for people to donate based on their will.
Sponsorship and Partnerships: Corporate Sponsorships: Partner with corporate sponsorship, which might include pharmaceutical companies, health care businesses, and technology firms to host blood donation drives, events, and marketing campaigns. By way of compensation, sponsors can have brands displayed within the application, sponsored print ads and website content, and possibilities for CSR initiatives.

Initial Design:

The purpose of this section is to define the “Minimum Viable Product” (MVP).  It may also be useful to call out the scope and expected/known limitations for your product here.
Users : people
Signups / login
Update info
Receive notifications/ emails regarding blood groups required
See nearby hospitals
See blood drives
Financial donations - Allow user to donate
See stats and facts
User : hospitals
Signups / login
See all donors
Request for blood group,(sends notifications to all nearby donors)
Financial donations



UI/UX Design


Technical Architecture
(What are the necessary components to support an MVP?  Data structures?  Storage considerations?  Web/cloud interactions?  Be sure to put in some thoughts as to how to measure your success here.  Call out dependencies on 3rd party services/APIs here, too)

System Components:

Mobile App: Consumer-side, web and mobile forms of accessibility for this application. Interface for the registration, login, blood donation requests as well as notifications and others, in short all the user interactions is provided.
Backend Server: The critical element which is responsible for the orderly execution and completion of all user requests, storing the data as well as the connection between frontend interface, database, and any external services.  - Will use the app's codebase for the same.
Database: Create a data management system to store user’s information, hospital details, blood donation requests and any other related data in an organized format. These systems implement a relational database like MySQL.
Authentication Service: Ensures that there are authentication processes using stronger mechanisms for user authorization, such as multi-factor authentication (MFA). A better user experience should be provided via the linking with Firebase Authentication with analogous services and this will handle user sign-up, login, and session management.
Geolocation Service: Create location based capabilities such as getting addresses of hospitals, blood donation centers and more. Keep track of blood donation drives also. Integration of mapping APIs such as Google Maps or Mapbox as well as providing search functionality will offer accurate geolocation functions.
Data Flow:
User Registration and Authentication: Users who access the application from the frontend of the interface must first provide authentication, as the communication process between the frontend interface and the backend server takes place.
Blood Donation Requests: Hospital staff search for blood donations through the server back-end, which checks for availability of nearby registered donors and pushes out notifications to those donors via email  and push notification.
Database Operations: After receiving the data from general users, the hospital staff, and other people in charge (donation request), the backend server communicates with the database to store and retrieve user profiles, hospital information, donation requests, and other critical data.

Challenges and Open Questions

Technical challenges: Ensuring scalability and performance of the application,especially during critical times. Optimized solutions might involve optimizing database queries and utilizing caching mechanisms.
Data privacy and security: Addressing challenges and concerns regarding the storage and handling of sensitive user data and hospital data. Solutions may include implementing encryption and adhering to regulatory standards such as HIPAA.
User adoption: Inspiring wide-scale acceptance for the app from both the donors and the hospitals. Tactics can include, but not limited to customized marketing programs and conjunction with health organizations.
Legal considerations: Ensure the adherence to traditions and regulations of health services both in blood donation and in other healthcare areas. It will perhaps entail collaboration with legal experts in the quest of satisfactorily resolving the topic of intellectual property rights and insurance coverage.



 


