# Processo de Release

## Versão

Atualize `pubspec.yaml` no formato:

```yaml
version: MAJOR.MINOR.PATCH+BUILD
```

## Validação local

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter build web --release
flutter build apk --release
```

## Publicação

Crie e envie uma tag:

```bash
git tag v1.1.0
git push origin main
git push origin v1.1.0
```

O GitHub Actions cria o release e anexa o APK.

## Loja Android

O APK do CI é um artefato de preview. Para loja, configure assinatura privada fora do repositório e gere AAB assinado.
