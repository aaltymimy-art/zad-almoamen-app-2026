# ملتقى العلم والدين

المشروع موجود في الفرع المستقل `multaqa-alilm-waldeen` داخل المستودع. لم يتم تعديل فرع `main` أو ملفات تطبيق زاد المؤمن.

## الملفات
- `multaqa/index.html`: واجهة التسجيل العربية بعشر روابط ولوحة الإدارة.
- `multaqa/schema.sql`: جداول قاعدة البيانات وسياسات أمان RLS.
- `.github/workflows/deploy-multaqa.yml`: سير عمل نشر GitHub Pages من مجلد multaqa.

## ما أصبح جاهزاً في الكود
- استمارة الاسم الكامل والعمر ورقم الهاتف والملف داخل الرابطة.
- لوحة إدارة عبر Supabase Auth.
- إحصائية إجمالية ولكل رابطة.
- بحث وتصفية وتعديل وحذف.
- تصدير CSV متوافق مع Excel ويدعم العربية.

## إعداد قاعدة البيانات قبل استقبال بيانات حقيقية
1. أنشئ مشروعاً في Supabase.
2. افتح SQL Editor وشغّل محتويات `multaqa/schema.sql`.
3. من إعدادات المشروع انسخ Project URL و anon/public key وضعهما في أعلى `multaqa/index.html` مكان النصين التوضيحيين. لا تضع Service Role Key في الواجهة مطلقاً.
4. أنشئ حساب مدير من Authentication > Users.
5. أضف UUID حساب المدير إلى جدول `public.admins` من SQL Editor:
   `insert into public.admins (user_id) values ('UUID-OF-ADMIN');`

## إعداد النشر
1. من إعدادات المستودع افتح Settings > Pages.
2. اجعل Build and deployment source هو GitHub Actions.
3. تأكد أن فرع العمل هو `multaqa-alilm-waldeen` وأن Workflow اسمه Deploy Multaqa site.
4. بعد نجاح تشغيل الـ workflow سيظهر رابط الموقع في Actions > آخر تشغيل > deploy. قد يكون شكل الرابط `https://aaltymimy-art.github.io/zad-almoamen-app-2026/`.

## الأمان والحالة
- سياسات RLS تسمح للزائر بإضافة تسجيل فقط، ولا تسمح له بقراءة بيانات الأعضاء.
- القراءة والتعديل والحذف متاحة لحسابات Auth التي يضاف UUID الخاص بها إلى جدول admins.
- اختبر الصلاحيات بحساب زائر وحساب مدير قبل إطلاق التسجيل العام.
- أسماء الروابط مؤقتة (الرابطة 1 إلى الرابطة 10)، والشعار الحالي حرف مؤقت إلى حين تزويدنا بأسماء الروابط والشعار الرسمي.
- لم تُضبط بيانات Supabase أو إعدادات Pages بعد؛ لذلك لا يوجد حالياً رابط حي يستقبل التسجيلات.
