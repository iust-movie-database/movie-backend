CREATE TABLE review (
    title_id BIGINT REFERENCES title(title_id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(user_id) ON DELETE CASCADE,
    score INTEGER CHECK (score IS NULL OR (score >= 1 AND score <= 10)) DEFAULT NULL,
    comment TEXT,
    is_spoiler BOOLEAN DEFAULT FALSE,
    review_date DATE DEFAULT CURRENT_DATE CHECK (review_date <= CURRENT_DATE),
    PRIMARY KEY (title_id, user_id)
);