# Flutter FFI CI Project

Этот проект был сгенерирован автоматически. Он содержит конфигурацию для FFI (C code) и GitHub CI.

### Как запустить (Важно!)

Так как этот ZIP содержит только измененные файлы конфигурации и исходный код, вам нужно восстановить стандартные файлы Flutter (Gradle wrapper и т.д.).

1. Распакуйте архив.
2. Откройте терминал в папке `webview_ci_app`.
3. Запустите команду:
   ```bash
   flutter create . --org com.bowlmates.app
   ```
4. **ВАЖНО:** Когда Flutter спросит, перезаписывать ли существующие файлы:
   - `android/app/build.gradle`: Ответьте **n** (нет), чтобы сохранить настройки FFI.
   - `lib/main.dart`: Ответьте **n** (нет), чтобы сохранить код вызова C-функции.
   - `android/app/src/main/AndroidManifest.xml`: Ответьте **n** (нет).
   - Если спросит про другие файлы (например `README.md`), тоже лучше **n**.

   *Если вы случайно перезаписали их:* просто скопируйте файлы из архива снова.

5. Запустите локально:
   ```bash
   flutter run
   ```

6. Загрузите на GitHub:
   ```bash
   git init
   git add .
   git commit -m "Initial commit with FFI"
   # git remote add origin <ваша-ссылка>
   # git push -u origin main
   ```

После пуша GitHub Actions автоматически соберет APK.
