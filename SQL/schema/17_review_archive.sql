CREATE TABLE review_archive (
    archive_id BIGSERIAL PRIMARY KEY,
    title_id BIGINT,
    user_id BIGINT,
    score INT,
    comment TEXT,
    is_spoiler BOOLEAN,
    review_date DATE,
    archived_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);