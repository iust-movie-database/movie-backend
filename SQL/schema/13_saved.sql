CREATE TABLE saved (
    user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    added_date DATE DEFAULT CURRENT_DATE CHECK(added_date <= CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'Want to Watch' CHECK (status IN ('Want to Watch', 'Watching', 'Watched')),
    PRIMARY KEY (user_id, title_id)
);