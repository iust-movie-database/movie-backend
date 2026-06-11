CREATE OR REPLACE PROCEDURE archive_old_reviews_clean()
LANGUAGE plpgsql
AS $$
DECLARE
    v_review RECORD;
    v_cursor CURSOR FOR
        SELECT review_id, title_id, user_id, score, comment, review_date
        FROM review
        WHERE review_date < '2020-01-01';
BEGIN
    OPEN v_cursor;
    
    LOOP
        FETCH v_cursor INTO v_review;
        EXIT WHEN NOT FOUND;
        
        BEGIN
            -- Insert into archive
            INSERT INTO review_archive (title_id, user_id, score, comment, review_date)
            VALUES (v_review.title_id, v_review.user_id, v_review.score, 
                    v_review.comment, v_review.review_date);
            
            -- Delete from original
            DELETE FROM review WHERE review_id = v_review.review_id;
            
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE NOTICE 'Failed for review_id: %', v_review.review_id;
        END;
    END LOOP;
    
    CLOSE v_cursor;
END;
$$;