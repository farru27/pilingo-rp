-- PILINGO RP V2 - Supabase
-- Ejecutar en Supabase > SQL Editor

create extension if not exists pgcrypto;

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'Soporte'
    check (role in ('Fundador','Administrador','Moderador','Soporte')),
  created_at timestamptz not null default now()
);

create table if not exists staff (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  avatar_url text,
  discord text,
  role text not null default 'Soporte'
    check (role in ('Fundador','Administrador','Moderador','Soporte')),
  created_at timestamptz not null default now()
);

alter table profiles enable row level security;
alter table staff enable row level security;

drop policy if exists "Perfil propio" on profiles;
create policy "Perfil propio"
on profiles for select
to authenticated
using (id = auth.uid());

drop policy if exists "Staff público" on staff;
create policy "Staff público"
on staff for select
to anon, authenticated
using (true);

drop policy if exists "Staff autenticado" on staff;
create policy "Staff autenticado"
on staff for insert
to authenticated
with check (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
      and profiles.role in ('Fundador','Administrador')
  )
);

drop policy if exists "Staff editar" on staff;
create policy "Staff editar"
on staff for update
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
      and profiles.role in ('Fundador','Administrador')
  )
)
with check (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
      and profiles.role in ('Fundador','Administrador')
  )
);

drop policy if exists "Staff eliminar" on staff;
create policy "Staff eliminar"
on staff for delete
to authenticated
using (
  exists (
    select 1 from profiles
    where profiles.id = auth.uid()
      and profiles.role in ('Fundador','Administrador')
  )
);

-- DESPUÉS de crear tu usuario en Authentication > Users,
-- reemplaza EL_UUID_DE_TU_USUARIO por su UUID y ejecuta:
--
-- insert into profiles (id, role)
-- values ('EL_UUID_DE_TU_USUARIO', 'Fundador');
