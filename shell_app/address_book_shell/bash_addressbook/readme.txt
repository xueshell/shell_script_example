-----------------------------------
Welcome to the Address Book readme!
-----------------------------------


--Using the App--

Entry to the app is via running the Menu script from the terminal. All details 
stored with the app are kept in a file named CustomerDetails that can be found 
in the main directory of the app.

--Adding Customers--
Adding customers is via the first option in the Address Book menu, or by 
running the AddCust script from the main application directory. All customers 
details must be valid, and the following outlines what is regarded as a valid 
entry for each of the customer fields:
  
    Email:    Must be composed of one or more characters followed by an '@' 
              symbol, which in turn is followed by one or more characters, an
              '.' and one or more characters. Email address must be unique and
              not already exist in the CustomerDetails file.

    Name:     Must be composed of alphabetic characters. Any spaces will be 
              replaced by hyphens.
    
    Surname:  Must be composed of alphabetic characters. Any spaces will be 
              replaced by hyphens.
    
    Alias:    Must be composed of alphabetic characters. Any spaces will be 
              replaced by hyphens.

    Address:  Must be composed of alphabetic, numeric characters, and commas.

    Phone:    Must be composed of numeric characters. Spaces will be replaced 
              by hyphens.

Each customer entry must be confirmed by the user before it is saved, whereupon
the user will be prompted to add any additional customers. If no is chosen, the 
AddCust script will exit, and the user returned to where they were before 
AddCust was run.

--Removing Customers--
Customers may be removed by chosing option 2 from the main Menu, or by running 
the RemCust script from the main application directory. 

Customers can be searched for with any search phrase, and the customer(s) that 
match that search term will be returned, and the user asked if this is who they 
wish to remove. If yes, deletion occurs from the address book, otherwise no one 
is deleted, and the user asked if they wish to remove anyone else. If yes, the 
previous procedure repeats, otherwise the user is returned to where they were 
before they RemCust was called. 

--Searching for Customers--
Customers can be searched for within the app by choosing option 3 from the main 
Menu, or by calling the FindCust script from the main app directory.

The user can search for customers with any pertinent search phrase, and any 
customers that match will be returned. Additional searches may be performed if
desired, and the user is returned to where they were before FindCust was 
called, when they are finished searching.

--Emailing Customers--
Customers can be emailed by opting for option 4 from the main Menu, or by 
calling the Email script. Customers can be emailed individually, or via a group
email facility where the entire customer base receives the same message. 

To email an individual customer, the user is prompted to search for the desired 
customer. If more than one customer is returned by the users search, the user 
will be prompted to search again. Likewise if no customers are returned by the
search. Once a valid customers is located, you will be prompted to confirm 
whether you wish to email this customer. If so, options to enter a subject and
body for the message are presented, and the email sent.

If you wish to email more than one customer, you will have the chance to do so,
and you will be asked if you wish to email anyone else after sending an email. 

If you are done emailing and respond so, the Email script will exit, returning
you to the point where you were before the Email script was called.

In emailing the entire customer base, the address book will pull all email 
addresses from the address book, prompt the user for a message subject and the 
message text they wish to include in the email, before sending the message to 
all customers. The user will however have the chance to confirm they want to 
email all customers with this message before a mass message is sent. 

As with individual emails the user will be given the chance to confirm whether
the customer chosen is the once they wish to email. If so, a subject and 
message body will be prompted for, and the message sent. Equally the procedure
whether to send additional email, or to exit the Email script is the same as 
with individual emails.