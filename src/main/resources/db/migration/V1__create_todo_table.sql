create table if not exists todo (
    id serial,
    title varchar (255) not null,
    description text,
    created_at timestamp not null default now(),
    updated_at timestamp,
    deleted_at timestamp,
    primary key (id)
);
