-- =====================================================================
-- E-COMMERCE ANALYTICS DATABASE
-- Database: MySQL 8
-- Purpose:
-- This schema stores transactional, product, customer, clickstream,
-- and application telemetry data for an e-commerce analytics platform.
-- =====================================================================

-- Create the database only if it does not already exist.
CREATE DATABASE IF NOT EXISTS ecommerce_analytics;

-- Switch to the newly created database.
USE ecommerce_analytics;

-- =====================================================================
-- TABLE: users
-- Stores customer account information.
-- =====================================================================

CREATE TABLE users (

    -- Unique identifier for every user.
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    -- Date the customer registered.
    signup_date DATE NOT NULL,

    -- Country where the customer resides.
    country VARCHAR(56),

    -- Customer subscription plan.
    -- ENUM restricts values to only the listed options.
    plan_type ENUM('free','pro','enterprise')
        DEFAULT 'free',

    -- User email.
    -- UNIQUE ensures duplicate email addresses cannot exist.
    email VARCHAR(255) UNIQUE,

    -- Whether the account is currently active.
    -- BOOLEAN is an alias for TINYINT(1) in MySQL.
    -- CHANGED:
    -- Using BOOLEAN makes the schema easier to read.
    is_active BOOLEAN DEFAULT TRUE  

) ENGINE=InnoDB;

-- =====================================================================
-- TABLE: products
-- Stores product catalogue information.
-- =====================================================================

CREATE TABLE products (

    -- Unique product identifier.
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    -- Product category.
    category VARCHAR(64) NOT NULL,

    -- Product name.
    product_name VARCHAR(255) NOT NULL,

    -- Current selling price.
    unit_price DECIMAL(10,2) NOT NULL,

    -- Product launch date.
    launched_at DATE

) ENGINE=InnoDB;

-- =====================================================================
-- TABLE: orders
-- Stores one record per customer order.
-- =====================================================================

CREATE TABLE orders (

    -- Unique order ID.
    order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    -- Customer who placed the order.
    user_id INT UNSIGNED NOT NULL,

    -- Date and time of purchase.
    order_date DATETIME NOT NULL,

    -- Current order status.
    status ENUM(
        'pending',
        'completed',
        'cancelled',
        'refunded'
    ) NOT NULL,

    -- Total order value.
    total_amount DECIMAL(12,2),

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE

) ENGINE=InnoDB;

-- =====================================================================
-- TABLE: order_items
-- Stores each individual product purchased within an order.
-- One order can contain multiple products.
-- =====================================================================

CREATE TABLE order_items (

    -- Unique line item ID.
    order_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    -- Order containing this product.
    order_id INT UNSIGNED NOT NULL,

    -- Purchased product.
    product_id INT UNSIGNED NOT NULL,

    -- Number of units purchased.
    quantity INT NOT NULL,

    -- Product price at purchase time.
    -- IMPORTANT:
    -- This stores the historical selling price even if the product
    -- price changes later.
    unit_price DECIMAL(10,2) NOT NULL,

    -- -----------------------------------------------------------------
    -- AMENDMENT
    -- Named foreign key with cascading delete.
    -- Deleting an order automatically deletes all its order items.
    -- -----------------------------------------------------------------
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)

) ENGINE=InnoDB;
-- =====================================================================
-- END OF SCHEMA
-- =====================================================================