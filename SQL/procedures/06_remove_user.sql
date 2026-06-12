CREATE OR REPLACE PROCEDURE remove_user(
    p_user_id BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM users WHERE user_id = p_user_id;
END;
$$;