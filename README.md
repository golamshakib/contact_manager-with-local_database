
# Contact Management App

This is a **Flutter Contact Management App** designed to store, display, and manage personal contacts. The app allows users to create, update, delete, and view contact details such as names, phone numbers, email addresses, and more. The app uses **SQLite** as the local database for storing contact information and supports features such as contact categorization, gender selection, and profile pictures.

## Features

- **Create Contacts**: Add new contacts with details like name, phone, email, address, website, and profile picture.
- **Edit Contacts**: Update existing contact details.
- **Delete Contacts**: Remove contacts from the database.
- **Favorite Contacts**: Mark contacts as favorites for easier access.
- **Profile Pictures**: Use the device camera or gallery to set profile images.
- **Gender Selection**: Select a contact's gender (Male/Female).
- **Group Contacts**: Assign contacts to groups for better organization.
- **Date of Birth**: Store and display a contact’s date of birth.
- **Mobile Validation**: Ensures phone numbers are valid.
- **SQLite Database**: Contacts are stored locally using SQLite.

## Screenshots

**Home Page**
![home](https://github.com/user-attachments/assets/28db480a-e667-4a92-ae40-207cfc13abc5)
**Create New Contact Page**
![create_contact](https://github.com/user-attachments/assets/7fb54684-6503-497f-a2e9-8ba9f68238c2)


## Getting Started

### Prerequisites

Ensure you have the following installed:

- **Flutter SDK**
- **Android Studio** or **VS Code**
- **sqflite** for SQLite database integration
- **image_picker** for selecting images
- **intl_phone_field** for phone number input validation

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/golamshakib/contact_manager-with-local_database
   ```

2. Navigate to the project directory:

   ```bash
   cd contact_manager-with-local_database
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Project Structure

The app follows a clean, organized folder structure:

- **lib/**:
    - `models/`: Contains contact and other relevant models.
    - `providers/`: State management using Provider.
    - `screens/`: UI screens for contact list, creation, and detail views.
    - `widgets/`: Reusable UI components.
    - `helpers/`: Database helper classes for managing SQLite.

## Key Packages Used

- `provider`: For state management.
- `sqflite`: To handle the SQLite database.
- `image_picker`: For selecting images from the gallery or camera.
- `intl_phone_field`: For phone number input and validation.
- `flutter_local_notifications`: To set reminders for contact birthdays.

## License

This project is licensed under the MIT License.

---

Feel free to customize it further based on your project’s specifics!