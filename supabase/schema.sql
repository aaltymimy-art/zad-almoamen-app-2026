-- ملتقى العلم والدين: قاعدة بيانات التسجيل
-- نفّذ هذا الملف في Supabase SQL Editor بعد إنشاء مشروع جديد.

create table if not exists public.member_registrations (
  id uuid primary key default gen_random_uuid(),
  association_no smallint not null check (association_no between 1 and 10),
  full_name text not null check (char_length(trim(full_name)) between 2 and 180),
  age smallint not null check (age between 1 and 110),
  phone text not null check (char_length(trim(phone)) between 7 and 24),
  role_description text not null check (char_length(trim(role_description)) between 2 and 2000),
  created_at timestamptz not null default now()
);

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

alter table public.member_registrations enable row level security;
alter table public.admin_users enable row level security;

-- يسمح للزائر بإرسال تسجيل جديد فقط، ولا يسمح له بقراءة أو تعديل أي تسجيل.
drop policy if exists "public can submit registration" on public.member_registrations;
create policy "public can submit registration"
on public.member_registrations for insert
to anon, authenticated
with check (
  association_no between 1 and 10
  and char_length(trim(full_name)) between 2 and 180
  and age between 1 and 110
  and char_length(trim(phone)) between 7 and 24
  and char_length(trim(role_description)) between 2 and 2000
);

-- لا يستطيع قراءة بيانات المسجلين إلا حساب أُضيف يدوياً إلى admin_users.
drop policy if exists "admins can read registrations" on public.member_registrations;
create policy "admins can read registrations"
on public.member_registrations for select
to authenticated
using (
  exists (
    select 1 from public.admin_users
    where admin_users.user_id = (select auth.uid())
  )
);

drop policy if exists "admins can read own admin record" on public.admin_users;
create policy "admins can read own admin record"
on public.admin_users for select
to authenticated
using (user_id = (select auth.uid()));

-- لا توجد سياسة عامة للتعديل أو الحذف. تُدار هذه العمليات من لوحة موثوقة فقط.
