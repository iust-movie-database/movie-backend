CREATE TABLE crew_member (
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    person_id BIGINT NOT NULL REFERENCES person(person_id) ON DELETE CASCADE,
    role_id BIGINT NOT NULL REFERENCES role(role_id) ON DELETE CASCADE,
    ordering INTEGER,
    PRIMARY KEY (title_id, person_id, role_id)
);
