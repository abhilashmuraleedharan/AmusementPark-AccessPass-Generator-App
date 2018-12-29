# Amusement Park Access Pass Generator App
Treehouse | iOS TechDegree - Project 4 and Project 5

**Instructions**

As part of Project 4, you’ll create a system for creating and validating access passes to an amusement park. 
There are three types of people who can be granted access to the park: employees, vendors, and of course, guests. 
As you can imagine, these different groups are allowed to enter different areas of the park, 
and may or may not be permitted to do certain things, like ride the rides or receive discounts in certain eateries and shops, 
for example.

Within each category of park access, there should be several sub-categories with varying access rights. 
For example, guests can be “Classic”, “VIP”, or “Free Child”, with different privileges associated with each. 
Details on exactly what each type of entrant is permitted to do and what type of personal information is required from 
them are outlined in the Business Rules Matrix. The document can be downloaded in the Project Resources area.

This project is divided into two parts. Part 1, outlined here as Project 4, will focus on building the data structures, 
object definitions, logic, error handling and other plumbing for the app. 
No user interface will be built at this stage. Your code will be built, tested and run by using temporary hard-coded “plug” values (or test cases).

To get an "exceeds" rating in this project, you can expand on the project in the following ways:

* When processing a swipe (or part of the swipe processing flow) polymorphic methods are being implemented, 
  such that a method is able to handle (or to be applied to) multiple entrant or pass types
* Add a feature to the swipe method(s), so that when an entrant swipes on their birthday, 
  they receive a personalized message, if their birthday is known.
* Add a feature to prevent a guest from swiping into the same ride twice in row within 5 seconds at the same checkpoint. 
  This is to prevent someone from sneaking in a second person. Rejecting an entrant’s second swipe should be done 
  gracefully with an alert message.
  

In Project 5, construct an iPad user-interface as per the screenshots in the project mockup. Your app should look as close as possible to the screenshots. You are free to to add your own design elements (images, fonts, colors) as long as the layout remains consistent with the mockups provided. The UI elements such as entry boxes and labels need to be enabled/disabled (or made visible/hidden) depending on the entrant type the user selects.

Utilize the code created in Project 4 as the business logic foundation for the user interface. You may need to refactor, enhance or rewrite some of the code from Project 4 in order to satisfy the expanded requirements for this project, which are detailed in the Business Rules Matrix and the Entrant Access Rules documents.

Make sure your app can perform all of the following tasks:

* Create entry passes for the all the entrant types listed for Project 4 (Classic, VIP, Free Child, Manager, Hourly  
  Employee:Food, Hourly Employee Maintenance)
* Create entry passes for the four additional entrant types listed for Project 5 (Season Pass Guest, Senior Guest, Contract 
  Employee, Vendor)
* Ensure that all necessary information is present before issuing a particular type of pass, otherwise, display an 
  appropriate alert message
* Provide a set of correct values for the selected entrant type when the user clicks the “Populate Data” button

To get an "exceeds" rating in this project, you can expand on the project in the following ways:

* Add additional input validation to ensure that phone numbers and zip codes are all numerical, birthday is of the correct 
  format (MM/DD/YYYY) and that all text entries are of “reasonable” length. You can decide what you deem reasonable, and put 
  it in the relevant comment in the code. You will only be graded on the implementation. An alert needs to be generated to 
  notify the user that there is an invalid input. Please do make sure you put in clear related comments to 
  communicate to the reviewer.
* Add a feature to the swipe method(s), so that a “ding” sound is played when an entrant is granted access and a “buzz”   
  sound is played when an entrant is denied access.

