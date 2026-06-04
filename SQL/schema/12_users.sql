CREATE TABLE users(
	user_id BIGSERIAL PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE CHECK (email ~ '^[^@]+@[^@]+\.[^@]+$'),
    password_hash VARCHAR(255) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE CHECK (join_date <= CURRENT_DATE)
);