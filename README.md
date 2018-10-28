# Amusement Park Access Pass Generator App
Treehouse | iOS TechDegree - Project 4

**Instructions**

For this project, you’ll create a system for creating and validating access passes to an amusement park. 
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

To get an "exceeds" rating, you can expand on the project in the following ways:

* When processing a swipe (or part of the swipe processing flow) polymorphic methods are being implemented, 
  such that a method is able to handle (or to be applied to) multiple entrant or pass types
* Add a feature to the swipe method(s), so that when an entrant swipes on their birthday, 
  they receive a personalized message, if their birthday is known.
* Add a feature to prevent a guest from swiping into the same ride twice in row within 5 seconds at the same checkpoint. 
  This is to prevent someone from sneaking in a second person. Rejecting an entrant’s second swipe should be done 
  gracefully with an alert message.
