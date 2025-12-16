# Flutter FFI CI Project

Проект настроен для тестирования FFI с GitHub Actions.

### Как это работает
В этом репозитории нет папки `android/`. 
GitHub Action (**build.yml**) автоматически запускает `flutter create .`, чтобы создать свежую структуру Android проекта, а затем с помощью скриптов внедряет настройки CMake и C-кода.

Это гарантирует успешную сборку без ошибок "Deprecated Android v1 Embedding".

### Локальный запуск
Если вы хотите запустить это на своем компьютере:
1. `flutter create . --org com.bowlmates.app`
2. Добавьте в `android/app/build.gradle` внутрь блока `android {}` (но не в defaultConfig):
   ```gradle
   externalNativeBuild {
       cmake {
           path "CMakeLists.txt"
       }
   }
   ```
3. `flutter run`
