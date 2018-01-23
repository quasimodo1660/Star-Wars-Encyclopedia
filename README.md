# Star-Wars-Encyclopedia

GET People
Use the foundation that we have built in the past 2 chapters to finish implementing the GET /People/ route.

After completion your application should look like this:



Please note that at first your UI may take several seconds to load properly. We will fix this in the coming chapters.

Tips:
You will need to modify the "people" array and initialize it as an empty array
From the resultsArray you will need to pull out the name of each entry to populate the table. This logic can be done in the viewDidLoad method when adding the information to the "people" array as well as in the tableView cellForRowAtIndexPath method. What are the advantages or disadvantages of both approaches?
\n

Ninja Hacker Level (Optional):
Currently, we are only showing 10 entries. If we look back at the "jsonResult" we will see a "count" that indicates that there should be 87 entries. There is also a "next" key that gives a URL to access the next page of entries. Leverage these two to populate the table view with all of the people from SWAPI.
The UI is loading extremely slowly. To fix this we need to deal with the "GCD" in iOS. Spend no more than 20 minutes learning about the Grand Central Dispatch and exploring ways to make your UI load faster.

\n
MVC in iOS\n
So far we have made our requests in the viewDidLoad method and wherever else we needed the data. This is ok for a small scale application but as our application grows larger we need to create an organizational scheme to handle this.

For our application, we already have the V and the C (our scenes and the viewController classes that manage them). Let's split out the M part so that we can have a class that gets all of our data for us!

First, create a new file in your encyclopedia project called "StarWarsModel.swift"

Now let's add the functionality to StarWarsModel.swift so that we can use the class to make our request for us. Similar to our Models in Django or Codeigniter, our StarWarsModel.swift file will be a class with methods that get data. Instead of these methods querying the database, however, they will be making requests to the Star Wars API to get the data and bring it back.

Start by creating the StarWarsModel.swift file and adding the "getAllPeople" static function to the StarWarsModel class.
\n
import Foundation
class StarWarsModel {
    // Note that we are passing in a function to the getAllPeople method (similar to our use of callbacks in JS). This function will allow the ViewController that calls this method to dictate what runs upon completion.
    static func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url that we will be sending the GET Request to
        let url = URL(string: "http://swapi.co/api/people/")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }
}
Now this means that we need to now call this getAllPeople function from the PeopleViewController and pass in a function to produce the same functionality that we had before. Let's take a look at how the PeopleViewController changes:

override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
                do {
                    // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] as? NSArray {
                            for person in results {
                                let personDict = person as! NSDictionary
                                self.people.append(personDict["name"]! as! String)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
        })
    }
And now we have separated the functionality and organized it such that the StarWarsModel.swift handles making the requests while still allowing the ViewController to implement the logic that manipulates that data and displays it.

To Do:
Now implement the same organization for the FilmViewController.

Create a StarWarsModel.getAllFilms method similar to the getAllPeople method we created above.
Modify the code on FilmViewController so that it leverages the getAllFilms method.
