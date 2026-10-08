# FocusForge DB-Level Validation Observations Report

## 1. Problems Found in the Original Schema
The original `schema.sql` lacked database constraints, causing severe data integrity issues:
- **Missing Required Attributes:** `users.name`, `users.email`, `projects.project_name`, and `tasks.title` allowed `NULL` values.
- **Duplicate Identity Records:** `users.email` lacked a `UNIQUE` constraint, allowing multiple accounts under the same email.
- **Out-of-Bound States:** `tasks.priority` allowed negative values or numbers above 5 (e.g., 10 or 999).
- **Orphan Records:** `tasks.project_id` lacked a `FOREIGN KEY` constraint, allowing tasks to reference non-existent projects (e.g., `project_id = 999`).

---

## 2. Constraints Added & Justification

| Table | Column | Constraint Applied | Business Justification |
|---|---|---|---|
| `users` | `name`, `email` | `NOT NULL` | Guarantees user accounts always possess identifiable contact details. |
| `users` | `email` | `UNIQUE` | Prevents account collisions and ensures email acts as a unique primary key identifier. |
| `projects` | `project_name` | `NOT NULL` | Prevents unnamable/ghost projects from polluting the database. |
| `tasks` | `title` | `NOT NULL` | Ensures every task clearly identifies what action item needs to be completed. |
| `tasks` | `priority` | `CHECK (priority BETWEEN 1 AND 5)` | Enforces application UI sorting bounds at the database storage engine layer. |
| `tasks` | `project_id` | `FOREIGN KEY REFERENCES projects(id)` | Eliminates orphan tasks by enforcing relational integrity to a valid project. |

---

## 3. Verification Results
- **Valid Data (`sample_data.sql`):** Loaded cleanly with 0 errors.
- **Invalid Data (`constraints_test.sql`):** All 4 invalid inserts were rejected by PostgreSQL with explicit constraint violation errors.