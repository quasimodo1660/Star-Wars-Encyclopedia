# Star-Wars-Encyclopedia

GET People
Use the foundation that we have built in the past 2 chapters to finish implementing the GET /People/ route.

After completion your application should look like this:



Please note that at first your UI may take several seconds to load properly. We will fix this in the coming chapters.

Tips:
You will need to modify the "people" array and initialize it as an empty array
From the resultsArray you will need to pull out the name of each entry to populate the table. This logic can be done in the viewDidLoad method when adding the information to the "people" array as well as in the tableView cellForRowAtIndexPath method. What are the advantages or disadvantages of both approaches?
Ninja Hacker Level (Optional):
Currently, we are only showing 10 entries. If we look back at the "jsonResult" we will see a "count" that indicates that there should be 87 entries. There is also a "next" key that gives a URL to access the next page of entries. Leverage these two to populate the table view with all of the people from SWAPI.
The UI is loading extremely slowly. To fix this we need to deal with the "GCD" in iOS. Spend no more than 20 minutes learning about the Grand Central Dispatch and exploring ways to make your UI load faster.
