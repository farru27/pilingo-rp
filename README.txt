# PILINGO RP V2

App web para GitHub + Netlify + Supabase.

## Archivos
- `index.html`: aplicación completa.
- `supabase.sql`: tablas y políticas de seguridad.

## Configuración
1. Crear un proyecto en Supabase.
2. Ejecutar `supabase.sql` en SQL Editor.
3. Crear un usuario en Authentication > Users.
4. Crear su registro en `profiles` con rol `Fundador`.
5. Copiar Project URL y anon public key.
6. Pegarlos en `index.html`:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
7. Subir `index.html` a GitHub.
8. Conectar el repositorio con Netlify.

## Importante
Nunca colocar la `service_role key` en el frontend.
La URL y la anon public key sí pueden estar en el frontend cuando las políticas RLS están correctamente configuradas.

Discord:
https://discord.gg/ukEZEvkgwX

IP:
PRÓXIMAMENTE
