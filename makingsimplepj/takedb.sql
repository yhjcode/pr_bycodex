-- Recreate objects for the guestbook board.
-- Run this script with an Oracle account that has CREATE SEQUENCE privilege.

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE content_comments CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE contents CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE content_comments_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE contents_seq';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

CREATE SEQUENCE contents_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE content_comments_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE contents (
    idx NUMBER PRIMARY KEY,
    writer VARCHAR2(50) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    reg_date DATE DEFAULT SYSDATE NOT NULL,
    read_count NUMBER DEFAULT 0 NOT NULL
);

CREATE TABLE content_comments (
    comment_idx NUMBER PRIMARY KEY,
    content_idx NUMBER NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    content VARCHAR2(1000) NOT NULL,
    reg_date DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_content_comments_contents
        FOREIGN KEY (content_idx)
        REFERENCES contents (idx)
        ON DELETE CASCADE
);

INSERT INTO contents (idx, writer, title, content)
VALUES (contents_seq.NEXTVAL, 'admin', 'Guestbook started', 'This is the first guestbook post.');

INSERT INTO content_comments (comment_idx, content_idx, writer, content)
VALUES (content_comments_seq.NEXTVAL, 1, 'visitor', 'Welcome to the comment area.');

COMMIT;
