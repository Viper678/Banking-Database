# Banking System Database

## Overview

This project implements a banking system database as part of the CS3120 Database Management Systems. It includes an ER diagram, relational model, procedures, functions, triggers, roles, indices, and views.

## Group Information

- **Members**:
  - Mohammed Abdul Azeem (111901032)
  - Vikas Naik Dharavath (111901052)
  - Bandi Kaushik (111901015)

## Features

- ER Diagram representing the banking system entities and relationships
- Relational model with entity and relationship tables
- Implemented constraints for data integrity
- Stored procedures for common banking operations
- Custom functions for data retrieval and calculations
- Triggers for automatic data updates and calculations
- Role-based access control (Manager, Officer, Customer)
- Indices for improved query performance
- Views for simplified data access

## Key Procedures

- `deposit()`: Handle account deposits
- `withdrawal()`: Process account withdrawals
- `transfer()`: Manage fund transfers between accounts
- `create_new_account()`: Set up a new customer account
- `create_another_account()`: Add an additional account for existing customers
- `create_loan()`: Process new loan applications

## Database Objects

- Tables: Branch, Customer, Loan, Employee, Payment, Account, Credit Card, Transactions
- Views: customer_info, customer_loan
- Roles: Manager, Officer, Customer
- Indices: Basic and composite indices for improved query performance

## Notes

- The database uses a custom schema named 'banking' with restricted public access
- Detailed constraints and business rules are implemented to maintain data integrity
- The system supports multiple account types and loan management

For more detailed information on the database structure and functionality, please refer to the full documentation.
