-- Revoke privileges from 'public' role
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE banking_db FROM PUBLIC;

-- customer_in_bank role
CREATE ROLE customer_in_bank;
GRANT CONNECT ON DATABASE banking_db TO customer_in_bank;
GRANT USAGE ON SCHEMA banking TO customer_in_bank;
GRANT SELECT ON banking.customer_info TO customer_in_bank;
ALTER DEFAULT PRIVILEGES IN SCHEMA banking GRANT SELECT ON TABLES TO customer_in_bank;

-- officer_in_bank role
CREATE ROLE officer_in_bank;
GRANT CONNECT ON DATABASE banking_db TO officer_in_bank;
GRANT USAGE, CREATE ON SCHEMA banking TO officer_in_bank;
GRANT SELECT, INSERT, UPDATE, DELETE ON banking.account, banking.borrower, banking.credit_card, banking.customer, banking.depositor, banking.loan, banking.payment, banking.transactions, banking.branch TO officer_in_bank;
ALTER DEFAULT PRIVILEGES IN SCHEMA banking GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO officer_in_bank;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA banking TO officer_in_bank;
ALTER DEFAULT PRIVILEGES IN SCHEMA banking GRANT USAGE ON SEQUENCES TO officer_in_bank;

--manager_in_bank role
CREATE ROLE manager_in_bank;
GRANT CONNECT ON DATABASE banking_db TO manager_in_bank;
GRANT USAGE, CREATE ON SCHEMA banking TO manager_in_bank;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA banking TO manager_in_bank;
ALTER DEFAULT PRIVILEGES IN SCHEMA banking GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO manager_in_bank;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA banking TO manager_in_bank;
ALTER DEFAULT PRIVILEGES IN SCHEMA banking GRANT USAGE ON SEQUENCES TO manager_in_bank;
ALTER role manager_in_bank with superuser;

-- Users creation
CREATE USER sandeep WITH PASSWORD 'sandeep';
CREATE USER ranjit WITH PASSWORD 'ranjit';
CREATE USER debojit WITH PASSWORD 'debojit';
CREATE USER lakshana WITH PASSWORD 'lakshana';
CREATE USER radhika WITH PASSWORD 'radhika';

-- Grant privileges to users
GRANT customer_in_bank TO sandeep;
GRANT customer_in_bank TO ranjit;
GRANT officer_in_bank TO debojit;
GRANT officer_in_bank TO lakshana;
GRANT manager_in_bank TO radhika;

set search_path to banking,public;

