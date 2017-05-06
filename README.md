# Zinc Challenge

Part 1 - 
cli_macbeth file completes the task. Run ruby bin/run.rb. To run the tests ruby spec/macbethLines.rb
Used VCR on tests to avoid calling the ibiblio server.

Part 2 & 3 -
Created rails application. This is rails_macbeth. Migrate the database and then start the server.
Models include version, character, and line_count. Line_count belongs to character and version. To query for character lines in a specific version would just do character.line_counts.find_by(version: version).
Doing it this way allowed me to avoid new instances of version class for each character or new instances of character class for each version (if wanted a belongs to relationship between them). 

I thought about a rake task to input the data into the DB but the instructions seemed to ask for it to come from user input.

The home page offers links to either look at all versions (version index page), add a version (input 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' to do this), or see the latest versions show page. 
The show page includes the table and chart (using chartkick) showing line count by character. I use a service model (app/services/analyzer) to handle the parsing and saving to DB.

The version model includes methods to extract a hash of character name and line count and a method to do this for just the characters with the 5 largest line counts for the index page. Both are sorted.  

