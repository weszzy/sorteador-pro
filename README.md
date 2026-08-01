<p align="center">
  <img width="112" alt="Sorteador Pro" src="assets/icon/app_icon.png">
</p>

# Sorteador Pro

Sorteador Pro é um app Flutter para montar times de forma rápida, justa e compartilhável. Foi feito para rachas, treinos, partidas entre amigos e qualquer cenário em que a lista de jogadores precisa virar times completos sem discussão.

<p>
  <a href="https://github.com/weszzy/sorteador-pro/actions/workflows/flutter_ci.yml"><img alt="CI" src="https://github.com/weszzy/sorteador-pro/actions/workflows/flutter_ci.yml/badge.svg"></a>
  <a href="LICENSE"><img alt="License GPL-3.0" src="https://img.shields.io/badge/license-GPL--3.0-blue"></a>
  <a href="https://github.com/weszzy/sorteador-pro/releases"><img alt="Releases" src="https://img.shields.io/github/v/release/weszzy/sorteador-pro?include_prereleases"></a>
</p>

## Destaques

- Sorteio normal com embaralhamento aleatório e times completos.
- Modo avançado para distribuir goleiros ou craques antes dos demais jogadores.
- Lista de próximos jogadores quando sobram nomes fora dos times.
- Histórico local dos sorteios com Hive.
- Compartilhamento do resultado como imagem.
- Interface premium com Material 3, temas e microinterações leves.

## Download

Baixe a versão mais recente em [GitHub Releases](https://github.com/weszzy/sorteador-pro/releases).

O APK publicado nos releases é um build público de preview. Para publicação em loja, gere um build assinado com chave privada.

## Stack

- Flutter e Dart
- Riverpod para estado
- Hive e SharedPreferences para persistência local
- share_plus, screenshot e path_provider para compartilhamento
- GitHub Actions para CI e releases

## Arquitetura

```text
lib/
├── core/            # tema, serviços e providers compartilhados
├── data/            # fontes de dados locais
├── domain/          # regras de sorteio
└── presentation/    # telas, providers de UI e widgets
```

Regras de negócio ficam em `domain/usecases`, persistência em `data/datasources` e interface em `presentation`.

## Qualidade

```bash
flutter pub get
flutter analyze
flutter test
flutter build web --release
```

## Release

Releases são gerados por tag:

```bash
git tag v1.1.0
git push origin v1.1.0
```

O workflow `Release` compila o APK, cria o release no GitHub e anexa o artefato.

## Licença

Distribuído sob GNU General Public License v3.0. Veja [LICENSE](LICENSE).
