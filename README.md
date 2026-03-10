# Wedding Planning Content Management System

This is a [Directus](https://directus.io/) database and management tool used for wedding planning and to populate the content of a [wedding website](https://github.com/dwaring87/wedding-site).

It can be used to manage customizable pages on the website, guest lists, and invitations to groups of guests.  The guests can RSVP to the wedding on the website and their information is stored in the database.  There is a pre-installed mailing lists module that allows you to send email messages to guests.

## Main Features

### <img width="51" height="48" alt="image" src="https://github.com/user-attachments/assets/121e8b50-e713-4a94-b506-24b9d5b4824d" /> Content

The content module is used to manage the data stored in the database.

#### Details: Information about the wedding and preferences for the website

These are properties that are used on the [website](https://github.com/dwaring87/wedding-site), such as:

- Name of the couple
- Wedding Date
- Contact Info
- Website URL
  
<img width="1969" height="1149" alt="image" src="https://github.com/user-attachments/assets/e8dbbd23-5e92-4a18-9b5b-6aaad4d6249e" />

<br /><hr /><br />

Details about the wedding venue, such as:

- Venue name
- Venue address
- Venue town
  
<img width="820" height="510" alt="image" src="https://github.com/user-attachments/assets/88533c87-3bb5-4ce5-9c58-50ae7e8d1edb" />

<br /><hr /><br />

A brief schedule outline includes the main details about the events for the wedding (such as a rehearsal dinner, wedding ceremony, reception, etc).  More information can be included on the linked schedule page.

<img width="837" height="566" alt="image" src="https://github.com/user-attachments/assets/bcb3ef2d-c085-4462-b763-45cb81e3f206" />

This information will be displayed on the homepage of the wedding website:

<img width="814" height="870" alt="image" src="https://github.com/user-attachments/assets/1e6066ec-8305-4907-bde8-017130173bc2" />

<br /><hr /><br />

The database can store [customizable pages](#pages-customizable-pages-for-the-website) that are displayed on the website.  One or more of these pages can be featured on the homepage of the wesbite (the rest are accessible from the toolbar at the top of every page).

<img width="810" height="343" alt="image" src="https://github.com/user-attachments/assets/99db475c-3245-42d0-8879-d1dee0cb5f36" />

If a page is featured, it is displayed in a box on the homepage below the schedule outline.

<img width="618" height="466" alt="image" src="https://github.com/user-attachments/assets/2ddc6811-1609-4db5-aef6-b654f8154948" />

<br /><hr /><br />

The RSVP feature of the website can be controlled by a number of options.  When enabled, users can go to the `/rsvp` page of the website, with links displayed prominently on the homepage and in the toolbar.  If the RSVP feature is disabled, there are no links displayed and any links to the `/rsvp` page will be redirected to the homepage.  If the RSVP feature is enabled, but RSVPs are closed (such as after a deadline to RSVP), users will see a customizable message explaining why RSVPs have been closed.

<img width="833" height="782" alt="image" src="https://github.com/user-attachments/assets/e8a899eb-c3e7-47fe-a5f9-88e0feb170b5" />

<br /><hr /><br />

Some basic visual options can be changed to customize the display of the website, such as the toolbar icon and various colors used throughout the site.

<img width="832" height="837" alt="image" src="https://github.com/user-attachments/assets/df64d88b-eeef-4c73-9b1b-6852e876fc97" />


#### Photos: Customizable photos displayed on specific pages of the website

There are a number of photos that are used on the wesbite and can be customized:

- **Home:** this photo is displayed on the homepage and has the couple's name, date, and venue displayed over it <img width="1202" height="804" alt="image" src="https://github.com/user-attachments/assets/352f6164-bbd6-4edb-a139-27ff4a06fb47" />
- **Info:** this photo is displayed on the More Information page (`/info`) along with a list of all of the pages<img width="941" height="974" alt="image" src="https://github.com/user-attachments/assets/90217878-e4fc-4650-8f54-f93148749ee1" />
- **RSVP:** this photo is displayed after a guest has RSVPed, along with a list of the pages on the website <img width="604" height="878" alt="image" src="https://github.com/user-attachments/assets/3b961001-fd4a-4e68-b7cb-8166402c756e" />


#### Guests: A list of all individuals invited to the wedding

The Guests collection is a table of all individuals invited to the wedding.

<img width="926" height="327" alt="image" src="https://github.com/user-attachments/assets/4ca50206-7026-45eb-b71d-fb7b83e46fd5" />

Details about the guests include:

- Name
- Email Address
- RSVP
- Associated Meal Choice
- Associated Dietary Restrictions
- Notes (a free-text field)
- Associated Invitation
- Associated Table

<img width="923" height="1197" alt="image" src="https://github.com/user-attachments/assets/0d9fc57b-5f01-40c6-997d-c8b181bea55c" />


If using the RSVP feature of the website, the user can update their own details (such as add an email address, select a meal choice, add any dietary restrictions, and add additional notes) when they RSVP.  The only required field when adding a new guest is their name.

#### Invitations: An address book for invitations, allowing guests to be grouped for shared invitations

Invitations represent the physical invites that would be sent out to individuals invited to the wedding.  An invitation can include one or more guests (such as all guests living in the same household).  Invitations include:

- Name (the name of the guests or family associated with the invitation)
- Address (mailing address for the invitation)
- Associated Guests (they must already exist in the Guests table before adding them to an invitation)
- Invite Code (a human-readable-id in the form of adjective-color-animal that is entered on the website to lookup the invitation when RSVPing)

<img width="922" height="857" alt="image" src="https://github.com/user-attachments/assets/0de11f6c-34d9-4359-81fa-e73e9077c64a" />


#### Meal Choices: offer meal choices to guests when they RSVP

These are the options for meals that are presented to a guest when they RSVP.  A meal choice includes a name and a description.  The Meal Choices table includes a count and list of all guests that have selected a particular choice.

<img width="925" height="266" alt="image" src="https://github.com/user-attachments/assets/6f8c3629-e1c6-4f94-bf0e-976746bae918" />

If the meal choices are removed from the database, a guest will not be prompted to select a meal choice when RSVPing.

#### Dietary Restrictions: keep track of individual's dietary restrictions

These are the pre-selected dietary restrictions that are presented to a guest when they RSVP.  You can change these options if you want different options for your guests.  A guest can also select an 'Other' option and give more details in the notes when they RSVP.

<img width="921" height="478" alt="image" src="https://github.com/user-attachments/assets/ccbd6976-9446-4892-b277-45df842b6474" />

#### Tables: table assignments for individuals

This collection contains all of the tables that will be available at the wedding.  You can assign guests to each table, making it easier to manage where people are sitting and find guests that have not been assigned a table yet.

<img width="917" height="717" alt="image" src="https://github.com/user-attachments/assets/94ccb7b0-2071-4685-9527-5bf70ff6a2ed" />

#### Pages: Customizable pages for the website

The pages collection contains all of the customizable pages for the website, such as information about how the couple met, details about the wedding, hotel blocks, gift registries, etc.  You can create any number of customizable pages, which will be linked from the toolbar on the website.  The content of each page is edited with a WYSIWYG editor and can include photos.  The page slug is used as the URL for the page.

<img width="929" height="1233" alt="image" src="https://github.com/user-attachments/assets/be8a8947-b2ae-4c06-8716-fd4cd539c1df" />

#### Recommendations: A list of local recommendations (restaurants, museums, parks, etc) for visiting guests

You can (optionally) include a list of recommended local attractions for guests unfamiliar with the area.  To enable this feature, create a page for recommendations and make sure the "Display Recommendations" option is enabled for that page.  Then, make any necessary changes to the recommendation categories (used to group recommendations of the same category) and the recommendations themselves.  The recommendations include:

- A category
- Name
- Location (such as the address)
- Description
- Website(s)
- Image

<img width="929" height="1233" alt="image" src="https://github.com/user-attachments/assets/481241c3-eb85-4d15-aa03-3e0239f0b2b1" />

The recommendations will then be displayed below the content of the recommendation page (the page with the "Display Recommendations" option enabled):

<img width="1029" height="1090" alt="image" src="https://github.com/user-attachments/assets/693121cb-c80a-46f7-a1ab-0b32335c7dcb" />

#### Alert: An important message displayed on all pages of the website

An alert is an important message that is displayed prominently on all pages of the website.  When enabled, it will display a title and message as a pop-up banner on every page.

<img width="830" height="298" alt="image" src="https://github.com/user-attachments/assets/38d1aaaf-19da-49c1-a429-b9c18a328b4a" />


### <img width="51" height="48" alt="image" src="https://github.com/user-attachments/assets/b0ce1149-b742-4c5d-9607-879dbfaacccc" /> Files

The files module can be used to manage additional files, such as photos, used as photos on the website and added to your pages.  Files can be uploaded from your device or downloaded from an external website with a URL.  You can organize photos in folders or with tags.

<img width="1214" height="716" alt="image" src="https://github.com/user-attachments/assets/72847138-d2b5-4625-8cf9-312f7e2117b3" />


### <img width="51" height="48" alt="image" src="https://github.com/user-attachments/assets/ed1635d5-f9ee-4d58-bcbc-68b0e106fac7" /> Mailing Lists

The Mailing Lists module can be used to send email messages to your guests.  The guests must have an email address added to their entry in the Guests table (either by you or after they've RSVPed).  There are two preconfigured mailing lists - one for all guests and one for guests that have RSVPed yes.  The body of the message can include variables, such as the guest's name (select a mailing list from the Lists panel and click the "Test" button to see all variables that are available).

<img width="1171" height="852" alt="image" src="https://github.com/user-attachments/assets/ce892ae9-97ca-4245-9f45-13f95c564f23" />

In order to use the mailing lists feature, an [email provider must be configured](https://directus.io/docs/configuration/email) with the Directus instance in order to send outgoing mail.


### <img width="51" height="48" alt="image" src="https://github.com/user-attachments/assets/8309f772-3f5c-4aa2-ace3-0d88fcda4e06" /> Users

The Users module contains the User Directory, which is a list of all accounts that can access the Directus CMS and view and/or modify contents of the database directly.  By default, there is your admin account, a Nuxt API account (which has minimal read permissions and update permissions on the guests table to fetch data for display on the website and allow guests to update their information via the website), and an Intial Setup account used to create the initial database structure (and has been disabled).

<img width="1456" height="393" alt="image" src="https://github.com/user-attachments/assets/334c1b39-1f11-49a8-b340-4c024c69c45d" />

You can create additional users to give others access to the database.  To do so, click the '+' icon in the top right and fill out the new user form.  The user should have a name, email address, and password set.  To give them full access to all collections in the database, you can assign them the Administrator role (under Admin Options at the bottom of the form).  You can also [create additional roles](https://directus.io/docs/guides/auth/access-control) if you want the user to have different access policies.

