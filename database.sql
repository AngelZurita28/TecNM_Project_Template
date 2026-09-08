BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS users (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    username varchar(64) NOT NULL,
    email varchar(254) NOT NULL,
    password_hash varchar(512) NOT NULL,
    name varchar(160) NOT NULL,
    role varchar(16) NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_users_username UNIQUE (username),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT ck_users_role CHECK (role IN ('Admin', 'User'))
);

INSERT INTO users (id, username, email, password_hash, name, role, is_active)
VALUES
    (
        '10000000-0000-4000-8000-000000000001',
        'admin',
        'admin@tecnm.local',
        'AQAAAAIAAYagAAAAEFPoBoqMJiXNZgGHwLI83gVWhlPCYz0LngL0FdXtf746DVm4MfEatXfZtA10ZQHUVw==',
        'Administrador Demo',
        'Admin',
        true
    ),
    (
        '10000000-0000-4000-8000-000000000002',
        'usuario',
        'usuario@tecnm.local',
        'AQAAAAIAAYagAAAAED8ZXms6S16ii//d3zmZH70AxF3rLs+PzAZS1ABU2tKCOT6NNuAmxnf5lqjCBCSFjQ==',
        'Usuario Demo',
        'User',
        true
    )
ON CONFLICT (username) DO UPDATE SET
    email = EXCLUDED.email,
    password_hash = EXCLUDED.password_hash,
    name = EXCLUDED.name,
    role = EXCLUDED.role,
    is_active = EXCLUDED.is_active;

COMMIT;
