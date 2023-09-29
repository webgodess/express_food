# Express Food Database

The Express Food Database is a MySQL database designed to support an online food delivery system. This database includes tables for managing users, addresses, menu items, order history, delivery managers, roles, and user roles. It also provides sample data to help you get started.

## Table of Contents

1. [Schema](#schema)
2. [Tables](#tables)
3. [Sample Data](#sample-data)

## Schema <a name="schema"></a>

The database schema is named `express_food` and uses the `utf8mb3` character set.

## Tables <a name="tables"></a>

### Users

- `users_ID`: Unique identifier for users.
- `firstName` and `lastName`: User's first and last name.
- `phone_number`: User's phone number.
- `email`: User's email address (unique).
- `password`: User's password.
- `role`: User's role (e.g., Client, DeliveryPerson).
- `create_time`: Timestamp for user creation.
- `update_time`: Timestamp for user profile updates.

### Addresses

- `Address_ID`: Unique identifier for addresses.
- `Street`, `Postal_Code`, and `City`: Address details.
- `users_ID`: User associated with the address.
- `create_time`: Timestamp for address creation.
- `update_time`: Timestamp for address updates.

### Categories

- `category_ID`: Unique identifier for menu item categories.
- `name`: Category name (e.g., Main, Dessert).
- `create_time`: Timestamp for category creation.
- `update_time`: Timestamp for category updates.

### OrderHistory

- `OrderHistory_ID`: Unique identifier for order history records.
- `Order_Date`: Date and time of the order.
- `create_time`: Timestamp for order history creation.
- `update_time`: Timestamp for order history updates.
- `users_ID`: User who placed the order.

### Delivery Manager

- `delivery_manager_id`: Unique identifier for delivery managers.
- `start_time` and `end_time`: Working hours for delivery managers.
- `users_ID`: User assigned as a delivery manager.
- `Address_ID`: Delivery manager's assigned address.
- `OrderHistory_ID`: Order history associated with the delivery.

### MenuItems

- `MenuItem_ID`: Unique identifier for menu items.
- `Name`: Name of the menu item.
- `Price`: Price of the menu item.
- `create_time`: Timestamp for menu item creation.
- `update_time`: Timestamp for menu item updates.

### Menu Schedule

- `Menu_schedule_id`: Unique identifier for menu schedule entries.
- `date`: Date for menu item availability.
- `MenuItem_ID`: Menu item available on the date.
- `create_time`: Timestamp for menu schedule creation.
- `update_time`: Timestamp for menu schedule updates.

### MenuItem Categories

- `MenuItem_categories_ID`: Unique identifier for menu item categories.
- `category_ID`: Category associated with the menu item.
- `MenuItem_ID`: Menu item associated with the category.
- `create_time`: Timestamp for category-menu item association.
- `update_time`: Timestamp for updates.

### MenuItem Order

- `MenuItem_Order_ID`: Unique identifier for menu item orders.
- `Quantity`: Quantity of the menu item in an order.
- `MenuItem_ID`: Menu item in the order.
- `OrderHistory_ID`: Order history associated with the menu item.
- `create_time`: Timestamp for menu item order creation.
- `update_time`: Timestamp for menu item order updates.

### Roles

- `roles_ID`: Unique identifier for roles.
- `role`: Role name (e.g., Client, DeliveryPerson).
- `create_time`: Timestamp for role creation.
- `update_time`: Timestamp for role updates.

### Users Roles

- `users_roles_ID`: Unique identifier for user roles.
- `users_ID`: User associated with the role.
- `roles_ID`: Role assigned to the user.
- `create_time`: Timestamp for user role assignment.
- `update_time`: Timestamp for role updates.

## Sample Data <a name="sample-data"></a>

The database script includes sample data to help you understand and test the database structure. It includes:

- Sample users with different roles (Client, DeliveryPerson).
- Sample addresses associated with users.
- Sample roles (DeliveryPerson, Client, Chef, Admin).
- Sample menu items with categories (Main and Dessert).
- Sample order history records.
- Sample delivery manager records.

Feel free to customize and expand upon this database structure and data to fit your specific requirements for an Express Food delivery system.
