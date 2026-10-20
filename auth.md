```mermaid

erDiagram

    ROLES ||--o{ USERS : "owned"
    USERS ||--o{ SESSIONS : "has"

    ROLES {
        int id PK
        string name UK
    }

    USERS {
        int id PK
        string email UK
        string password_hash
        int role_id FK
        timestamp created_at
    }

    SESSIONS {
        int id PK
        int user_id FK
        string token UK
        timestamp created_at
        timestamp expires_at
    }

```
