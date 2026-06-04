CREATE TABLE recommended (
    user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    date DATE DEFAULT CURRENT_DATE,
    score INTEGER,
    PRIMARY KEY (user_id, title_id)
);