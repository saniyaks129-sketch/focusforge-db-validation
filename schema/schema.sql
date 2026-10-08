-- FocusForge Fixed Schema with DB-Level Constraints

DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 1. Users Table (NOT NULL on name & email, UNIQUE on email)
CREATE TABLE users (
  id    INT PRIMARY KEY,
  name  VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Projects Table (NOT NULL on project_name)
CREATE TABLE projects (
  id           INT PRIMARY KEY,
  project_name VARCHAR(100) NOT NULL
);

-- 3. Tasks Table (NOT NULL on title, CHECK priority 1-5, FOREIGN KEY project_id)
CREATE TABLE tasks (
  id         INT PRIMARY KEY,
  title      VARCHAR(255) NOT NULL,
  priority   INT CHECK (priority BETWEEN 1 AND 5),
  project_id INT REFERENCES projects(id) ON DELETE CASCADE
);