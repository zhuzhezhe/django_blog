CREATE TABLE auth_group
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL
);
CREATE TABLE auth_group_permissions
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    group_id INT NOT NULL,
    permission_id INT NOT NULL
);
CREATE TABLE auth_permission
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    content_type_id INT NOT NULL,
    codename VARCHAR(100) NOT NULL
);
CREATE TABLE auth_user
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    password VARCHAR(128) NOT NULL,
    last_login DATETIME,
    is_superuser TINYINT NOT NULL,
    username VARCHAR(30) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(254) NOT NULL,
    is_staff TINYINT NOT NULL,
    is_active TINYINT NOT NULL,
    date_joined DATETIME NOT NULL
);
CREATE TABLE auth_user_groups
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    group_id INT NOT NULL
);
CREATE TABLE auth_user_user_permissions
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    permission_id INT NOT NULL
);
CREATE TABLE blog_category
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);
CREATE TABLE blog_page
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    author VARCHAR(20) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content LONGTEXT NOT NULL,
    time DATE NOT NULL,
    category_id INT NOT NULL,
    tag_id INT NOT NULL
);
CREATE TABLE blog_tag
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);
CREATE TABLE blog_user
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    mail VARCHAR(75) NOT NULL,
    pwd VARCHAR(20) NOT NULL
);
CREATE TABLE django_admin_log
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    action_time DATETIME NOT NULL,
    object_id LONGTEXT,
    object_repr VARCHAR(200) NOT NULL,
    action_flag SMALLINT UNSIGNED NOT NULL,
    change_message LONGTEXT NOT NULL,
    content_type_id INT,
    user_id INT NOT NULL
);
CREATE TABLE django_content_type
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    app_label VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL
);
CREATE TABLE django_migrations
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    app VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    applied DATETIME NOT NULL
);
CREATE TABLE django_session
(
    session_key VARCHAR(40) PRIMARY KEY NOT NULL,
    session_data LONGTEXT NOT NULL,
    expire_date DATETIME NOT NULL
);
CREATE UNIQUE INDEX name ON auth_group (name);
ALTER TABLE auth_group_permissions ADD FOREIGN KEY (permission_id) REFERENCES auth_permission (id);
ALTER TABLE auth_group_permissions ADD FOREIGN KEY (group_id) REFERENCES auth_group (id);
CREATE UNIQUE INDEX group_id ON auth_group_permissions (permission_id);
CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions (group_id);
CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions (permission_id);
ALTER TABLE auth_permission ADD FOREIGN KEY (content_type_id) REFERENCES django_content_type (id);
CREATE UNIQUE INDEX content_type_id ON auth_permission (codename);
CREATE INDEX auth_permission_417f1b1c ON auth_permission (content_type_id);
CREATE UNIQUE INDEX username ON auth_user (username);
ALTER TABLE auth_user_groups ADD FOREIGN KEY (group_id) REFERENCES auth_group (id);
ALTER TABLE auth_user_groups ADD FOREIGN KEY (user_id) REFERENCES auth_user (id);
CREATE UNIQUE INDEX user_id ON auth_user_groups (group_id);
CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups (group_id);
CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups (user_id);
ALTER TABLE auth_user_user_permissions ADD FOREIGN KEY (permission_id) REFERENCES auth_permission (id);
ALTER TABLE auth_user_user_permissions ADD FOREIGN KEY (user_id) REFERENCES auth_user (id);
CREATE UNIQUE INDEX user_id ON auth_user_user_permissions (permission_id);
CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions (permission_id);
CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions (user_id);
ALTER TABLE blog_page ADD FOREIGN KEY (category_id) REFERENCES blog_category (id);
ALTER TABLE blog_page ADD FOREIGN KEY (tag_id) REFERENCES blog_tag (id);
CREATE INDEX blog_page_76f094bc ON blog_page (tag_id);
CREATE INDEX blog_page_b583a629 ON blog_page (category_id);
CREATE UNIQUE INDEX pwd ON blog_user (pwd);
ALTER TABLE django_admin_log ADD FOREIGN KEY (content_type_id) REFERENCES django_content_type (id);
ALTER TABLE django_admin_log ADD FOREIGN KEY (user_id) REFERENCES auth_user (id);
CREATE INDEX django_admin_log_417f1b1c ON django_admin_log (content_type_id);
CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log (user_id);
CREATE UNIQUE INDEX django_content_type_app_label_3ec8c61c_uniq ON django_content_type (app_label, model);
CREATE INDEX django_session_de54fa62 ON django_session (expire_date);
