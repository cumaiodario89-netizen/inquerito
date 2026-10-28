-- Cole isto no Supabase: SQL Editor > New query > Run

create table if not exists public.respostas (
  id            bigint generated always as identity primary key,
  criado_em     timestamptz not null default now(),
  nome          text not null check (char_length(nome) between 2 and 120),
  email         text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]{2,}$'),
  whatsapp      text not null check (char_length(whatsapp) between 7 and 30),
  pais          text,
  provincia     text,
  cidade        text,
  idade         int check (idade is null or idade between 10 and 99),
  situacao      text,
  negocio       text check (negocio is null or char_length(negocio) <= 300),
  uso_ia        text,
  nivel         text,
  aprender      text,
  dificuldade   text check (dificuldade is null or char_length(dificuldade) <= 800),
  renda_extra   text,
  ja_ganha      text,
  como_ganhar   text,
  meta_mensal   text check (meta_mensal is null or char_length(meta_mensal) <= 80),
  tempo_dia     text,
  investimento  text,
  renda_atual   text,
  equipamento   text,
  impedimento   text,
  consentimento boolean not null default false check (consentimento = true)
);

-- Segurança: o site só pode INSERIR. Ninguém lê os dados pelo site.
alter table public.respostas enable row level security;

drop policy if exists "site pode inserir" on public.respostas;
create policy "site pode inserir"
  on public.respostas for insert
  to anon
  with check (true);

-- Sem política de SELECT: só você, logado no painel do Supabase, vê as respostas.
