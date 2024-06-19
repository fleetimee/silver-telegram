CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE f_threads
(
    thread_id      VARCHAR(255) DEFAULT ('threads_' || uuid_generate_v4()) PRIMARY KEY,
    thread_content TEXT         NOT NULL,
    thread_title   VARCHAR(255) NOT NULL,
    thread_status  VARCHAR(255) DEFAULT 'active',
    threads_views  INT          DEFAULT 0,
    last_posted_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    created_at     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    created_by     UUID         NOT NULL,
    updated_by     UUID         NOT NULL,
    is_approved    BOOLEAN      DEFAULT FALSE,
    approved_at    TIMESTAMP,
    approved_by    UUID,
    FOREIGN KEY (approved_by) REFERENCES users (uuid),
    FOREIGN KEY (created_by) REFERENCES users (uuid),
    FOREIGN KEY (updated_by) REFERENCES users (uuid)
);

CREATE TABLE f_thread_participants
(
    user_id   UUID         NOT NULL,
    thread_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id, thread_id),
    FOREIGN KEY (user_id) REFERENCES users (uuid),
    FOREIGN KEY (thread_id) REFERENCES f_threads (thread_id)
);

CREATE TABLE f_posts
(
    post_id      VARCHAR(255) DEFAULT ('posts_' || uuid_generate_v4()) PRIMARY KEY,
    post_content TEXT         NOT NULL,
    post_status  VARCHAR(255) DEFAULT 'active',
    thread_id    VARCHAR(255) NOT NULL,
    created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    created_by   UUID         NOT NULL,
    updated_by   UUID         NOT NULL,
    is_edited    BOOLEAN      DEFAULT FALSE,
    post_edited_at TIMESTAMP,

    FOREIGN KEY (thread_id) REFERENCES f_threads (thread_id),
    FOREIGN KEY (created_by) REFERENCES users (uuid),
    FOREIGN KEY (updated_by) REFERENCES users (uuid)
);

CREATE TABLE f_notifications
(
    notification_id VARCHAR(255) DEFAULT ('notifications_' || uuid_generate_v4()) PRIMARY KEY,
    user_id UUID NOT NULL,
    post_id VARCHAR(255) NOT NULL,
    thread_id VARCHAR(255) NOT NULL,
    notification_content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (uuid),
    FOREIGN KEY (post_id) REFERENCES f_posts (post_id),
    FOREIGN KEY (thread_id) REFERENCES f_threads (thread_id)
);


CREATE TABLE f_thread_categories
(
    category_id   VARCHAR(255) DEFAULT ('categories_' || uuid_generate_v4()) PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE f_threads
ADD COLUMN category_id VARCHAR(255),
ADD FOREIGN KEY (category_id) REFERENCES f_thread_categories (category_id);

CREATE TABLE f_tags
(
    tag_id   VARCHAR(255) DEFAULT ('tags_' || uuid_generate_v4()) PRIMARY KEY,
    tag_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE f_thread_tags
(
    thread_id VARCHAR(255) NOT NULL,
    tag_id    VARCHAR(255) NOT NULL,
    PRIMARY KEY (thread_id, tag_id),
    FOREIGN KEY (thread_id) REFERENCES f_threads (thread_id),
    FOREIGN KEY (tag_id) REFERENCES f_tags (tag_id)
);