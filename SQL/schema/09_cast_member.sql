CREATE TABLE cast_member (
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    person_id BIGINT NOT NULL REFERENCES person(person_id) ON DELETE CASCADE,
    role_id BIGINT NOT NULL REFERENCES role(role_id) ON DELETE CASCADE,
    char_name_fa VARCHAR(255) NOT NULL,
    char_name_en VARCHAR(255) NOT NULL,
    ordering INTEGER,
    PRIMARY KEY (title_id, person_id, role_id, char_name_en)
);
